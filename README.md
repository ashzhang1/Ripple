# Ripple

This project was developed as part of my honours thesis where I conducted research in the field of Human-Computer Interaction. The thesis aimed to design, develop and evaluate a novel personal informatics application, which I named Ripple.

Ripple is a personal informatics application designed to help older adults reflect upon their long-term physical activity data. The app has been developed as a native iOS application for the iPad using Swift, SwiftUI, and CoreData.

## Main Features

- Ripple has four main screens, being Calendar, Trends, Add Reflection, and My Reflections.
- **Calendar:** Visualise your step count data over the past 6 months through a calendar format. Days are categorised as either goal complete, over half complete, under half complete, or non-wear days. You can also apply filters to only see the days belonging to a specific goal threshold. Each of the months on the Calendar screen are clickable, so you can view data from an individual month including the top logged activities and emotions for that month.
- **Trends:** This page visualises your step count using a bar graph, where each bar is colour-coded to represent your average wear-time for that month. You can also see other infomation on this page such as clinician comments, supporter comments, and your top logged activities and emotions given the selected time interval.
- **Add Reflection:** Users can use this page to log their daily activities and how they felt for a given day. Also, users can record a more thorough monthly reflection. The monthly reflection can be recorded via speech or the traditional keyboard. The user's speech gets automatically transcribed on-screen as they talk. This was implemented to allow older adults who are less familiar with technology to easily record their reflections without having to type.
- **My Reflections:** Look back on your past reflections you have recorded.

## Getting Started

### Prerequisites:

- Xcode: Xcode 16.2 or later
- iPad device with at least iOs 18.1 to install Ripple onto (Or you can use the simulator).
- Apple Developer Account: You need this if you would like to install onto a personal iPad device. This is free, though the app can only live on your iPad for 7 days at a time.

### Installation:

1. Clone the repository.
2. Open project in Xcode.
3. Click the "Play" button (▶️) in Xcode or press Cmd + R

### Note:

- This application was developed for research purposes.
- The app currently reads synthetic data from several JSON files which are also located in this repo.
- Before the app launches, it reads the JSON data and loads it into CoreData. View the JSONLoader service under the services folder for more details.
- Before installing onto an iPad, you need to go into JSONLoader service and uncomment the following. This is because when the app launches, it checks if it has already loaded the data before. However, if you are looking to develop additional features, leave it commented out during development.

```
if userDefaults.bool(forKey: hasLoadedDataKey) {
    return
}
```

## Acknowledgements

- ChatGPT was used as a debugging tool throughout the development of Ripple.
