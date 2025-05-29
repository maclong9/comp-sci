# Computer Science Notes

This repository contains my computer science notes organized via an Xcode Playground and rendered to a custom [WebUI](https://github.com/maclong9/web-ui) site.

> [!NOTE]
> You can use this project as a starting point for any scientific note-taking project by clicking the `Use this template` button on GitHub.

## Development

1. Clone the repository.
2. Open the `xcworkspace` file in Xcode

### Note Taking

You can take notes in the `Notes.playground` directory, this is a collection of mixed _Markdown_ and _Swift_ files which can be used to write notes with runnable code within them. 

> [!IMPORTANT]
> Ensure that you check `Editor > Show Rendered Markup` before reading through the notes.

### Static Site Generation

The `Application` directory contains all you need for editing the end result that is generated for web pages based on the files within `Notes.playground`. For reference a lot of the components and metadata are fetched from my [Portfolio Shared Library](https://github.com/maclong9/portfolio/tree/main/Sources/Shared).

> [!NOTE]
> If you would like to use plain markdown instead of an Xcode playground, you can create an `Articles` directory in the root directory and remove the `Notes.playground` directory, make sure you edit the `Application/Sources/ProcessPages.swift` to reflect this change and you remove `Articles` from `.gitignore`.
