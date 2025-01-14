# Purrfect Facts – iOS Coding Challenge

Welcome to **Purrfect Facts**! This iOS project demonstrates the core functionality of fetching a **random cat image** and a **random cat fact** each time the user opens the app—or taps the screen. This coding challenge is intended to showcase a broad range of iOS development skillsets, from networking to JSON processing, SwiftUI, SwiftData integration and beyond.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Room for Improvement](#room-for-improvement)

---

## Overview
> **Purpose**: This challenge is designed to showcase a wide variety of fundamental iOS development skills, including:
> - Networking with `URLSession`
> - Swift 6
> - Swift concurrency (`async`/`await`)
> - Decoding JSON via `Codable`
> - SwiftUI 
> - Basic data persistence using SwiftData
> - Proper separation of responsibilities as per MVVM architecture

**Core functionality**:
1. Present a **random cat image** and **random cat fact** on app launch.  
2. On **tap**, fetch and display a **new** random cat image and cat fact.
3. Save a random cat fact to later viewing.
4. Show a list of "famous" cat breeds and their breed facts.

---

## Features
- **Random Cat Facts**  
  Fetched from [Meowfacts](https://github.com/wh-iterabb-it/meowfacts).
- **Random Cat Pictures**  
  Sourced from [The Cat API](https://developers.thecatapi.com/).
- **Tap to Refresh**  
  Every tap fetches fresh data in the background and updates the UI seamlessly.
- **Error Handling & Resilience**  
  Shows how to handle and display networking errors gracefully (could be improved or customized).
- **Swift Concurrency**  
  Utilizes `async/await` to simplify network call syntax and handle concurrency safely.

---

## Architecture
This app is organized with a **clean** or **MVVM**-like approach (depending on how you structure it). Here’s one sample flow:

1. **View** – Observes a `ViewModel`, displaying cat images and facts.  
2. **ViewModel** – Calls the **Service** to fetch data; holds state for the View.  
3. **Service** – Handles networking and returns decoded model objects.  
4. **Model** – Decoded from JSON (e.g., `CatFactDTO`, `CatImageDTO`).

---

## Requirements
1. Xcode **16** or higher.
2. iOS **18** or higher.

---

## Getting Started

1. **Clone the Repository**  
   ```bash
   https://github.com/echolumaque/Purffect-Facts
   cd your-purrfect-facts-repo
   
2. **Open the Project**
   - Double-click on PurrfectFacts.xcodeproj or open it via Xcode.

3.	**Build & Run**
    - Select the appropriate iOS Simulator or a real device in Xcode’s scheme.
    - Press ⌘ + R (Run).


## Usage
1.	Launch the App
    - You’ll see a random cat image and fact loaded automatically.
2.	Tap the Screen
    - Each tap triggers a new fetch of both the cat image and fact.
3.	Enjoy the Facts
    - Use it as a fun reference, or just amuse yourself with random kitty content.
  
  
## Room for Improvement
- Better Error Handling: Show a user-friendly message if the network fails.
- Caching: Implement image or fact caching to reduce repetitive network calls.
- Offline Mode: Persist previously loaded data so the user sees something if offline.
- Testing & Mocks: Expand unit test coverage, especially around network failures or decoding edge cases.
- UI Enhancements: Animate transitions between images and facts.
