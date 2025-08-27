# Music iOS Application

This is a SwiftUI application that displays music data fetched from a REST API. The app uses a custom-built FastAPI backend deployed on Docker and Render.

## What the App Does

- Displays a list of songs with meaningful information (title, artist, album, genre, image, description, etc.)
- Supports viewing detailed information for each song
- Handles loading and error states gracefully (e.g., network offline, API errors)
- Demonstrates good SwiftUI design and follows MVVM, clean code, and documentation practices

## API Endpoint

The app connects to the following API:  
**Production URL:** [https://music-api-service-1cp0.onrender.com](https://music-api-service-1cp0.onrender.com)

See below for API documentation.

## How to Run the App

1. **Requirements**
   - Xcode 15 or later
   - iOS 17.0+ target (recommended)
2. **Setup Steps**
   - Clone this repository:  
     `git clone https://github.com/bashlui/music-fullapp.git`
   - Open `music-fullapp.xcodeproj` with Xcode
   - Build and run on simulator or device

## MVVM, Clean Code & Documentation

- All network calls and data models are separated into service and model files
- Views are small and focused (see `ContentView.swift`, `Song.swift`, `MusicAPIService.swift`)
- Error handling and loading states are implemented (see usage of `ProgressView` and error strings)
- Comments are placed in relevant parts of the code to explain intent and clean code practices

## API Reference

### Welcome Message

**GET /**  
Returns a welcome message to test if the API is working.

**Response Example**
```json
["Hi! This is a music API developed by Tono, welcome!, feel free to explore."]
```

---

### Get All Songs

**GET /api/songs**  
Returns a list of all songs available in the API.

**Response Example**
```json
[
  {
    "id": 1,
    "title": "Song Title",
    "artist": "Artist Name",
    "album": "Album Name",
    "year": 2024,
    "genre": "Genre",
    "image_url": "https://example.com/image.jpg",
    "description": "Song description"
  }
]
```

---

### Get Song by ID

**GET /api/songs/{song_id}**  
Returns the song with the specified ID.

**Path Parameters**
- `song_id` (integer): The ID of the song to retrieve.

**Response Example**
```json
{
  "id": 1,
  "title": "Song Title",
  "artist": "Artist Name",
  "album": "Album Name",
  "year": 2024,
  "genre": "Genre",
  "image_url": "https://example.com/image.jpg",
  "description": "Song description"
}
```
**Error Response (404)**
```json
{
  "detail": "Song not found"
}
```

---

### Create a New Song

**POST /api/song**  
Creates a new song and adds it to the list.

**Request Body Example**
```json
{
  "id": 2,
  "title": "New Song",
  "artist": "New Artist",
  "album": "New Album",
  "year": 2025,
  "genre": "Pop",
  "image_url": "https://example.com/new-image.jpg",
  "description": "A new song description"
}
```

**Response Example**
```json
{
  "id": 2,
  "title": "New Song",
  "artist": "New Artist",
  "album": "New Album",
  "year": 2025,
  "genre": "Pop",
  "image_url": "https://example.com/new-image.jpg",
  "description": "A new song description"
}
```

**Error Response (400)**
```json
{
  "detail": "Song with this ID already exists"
}
```

---

### Search Songs

**GET /api/songs/search?q={query}**  
Returns a list of songs that match the search query in title, artist, album, or genre.

**Query Parameters**
- `q`: Search string (required)

**Response Example**
```json
[
  {
    "id": 1,
    "title": "Song Title",
    "artist": "Artist Name",
    "album": "Album Name",
    "year": 2024,
    "genre": "Genre",
    "image_url": "https://example.com/image.jpg",
    "description": "Song description"
  }
]
```

---

## Song Model

| Field       | Type   | Description        |
|-------------|--------|-------------------|
| id          | int    | Song ID           |
| title       | str    | Song title        |
| artist      | str    | Artist name       |
| album       | str    | Album name        |
| year        | int    | Release year      |
| genre       | str    | Genre             |
| image_url   | str    | Image URL         |
| description | str    | Song description  |

---

## API Server (music-api)

Find API documentation and deployment instructions in [music-api README](https://github.com/bashlui/music-api#readme).

## Example Commits

- Add API error handling
- Implement MVVM pattern for data loading
- Improve loading and offline network UI

---
