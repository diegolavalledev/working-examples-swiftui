import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), example: .sample, configuration: ConfigurationIntent(), isPlaceholder: true)
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), example: .sample, configuration: configuration)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    let example: ExampleModel
    if
      let userDefaults = UserDefaults(suiteName: "group.com.diegolavalle.WorkingExamples"),
      let examplesData = userDefaults.object(forKey: "examples") as? Data,
      let examples = try? JSONDecoder().decode([ExampleModel].self, from: examplesData),
      examples.count > 1 {
      example = examples[Int.random(in: 0 ..< examples.count)]
    } else {
      example = .sample
    }
    let entry = SimpleEntry(date: currentDate, example: example ,configuration: configuration)
    entries.append(entry)
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    let timeline = Timeline(entries: entries, policy: .after(tomorrow))
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  var date: Date
  let example: ExampleModel?
  let configuration: ConfigurationIntent
  var isPlaceholder = false
}

struct WorkingExampleWidgetEntryView : View {
  
  var entry: Provider.Entry
  
  var exampleBody: some View {
    VStack {
      if let example = entry.example {
        Spacer()
        Text(example.title).bold()
        Spacer()
        Text(example.subtitle).italic()
        Spacer()
      }
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity)
    .background(
      LinearGradient(gradient: Gradient(colors: [Color(.secondarySystemBackground), Color.accentColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
    )
    .edgesIgnoringSafeArea(.all)
    .accentColor(.blue)
  }
  
  var body: some View {
    if let example = entry.example {
      if entry.isPlaceholder {
        exampleBody.redacted(reason: .placeholder)
      } else {
        exampleBody.widgetURL(URL(string: example.relPermalink))
      }
    } else {
      VStack {
        Text("Please launch the app to get widgets from the network.")
      }
    }
  }
}

@main
struct WorkingExampleWidget: Widget {
  let kind: String = "workingexamplewidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      WorkingExampleWidgetEntryView(entry: entry).accentColor(Color("AccentColor"))
    }
    .configurationDisplayName("Daily Example")
    .description("A different working example everyday.")
    .supportedFamilies([.systemSmall])
  }
}

struct WorkingExampleWidget_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      WorkingExampleWidgetEntryView(entry: SimpleEntry(date: Date(), example: .sample, configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      WorkingExampleWidgetEntryView(entry: SimpleEntry(date: Date(), example: .sample, configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      .environment(\.colorScheme, .dark)
    }
  }
}
