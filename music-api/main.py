from fastapi import FastAPI
from fastapi.response import UJSONResponse

app = FastAPI()

songs = [{"id": 0, "title": "Sample Song", "artist": "Sample Artist", "description": "This is a sample song."}]

@app.get("/")
async def root():
    return {"message": "Welcome to the Music API"}

# Get all songs
@app.get("/songs", response_class=UJSONResponse)
async def get_songs():
    return {"songs": songs}

# Get a specific song by ID
@app.get("/songs/{song_id}", response_class=UJSONResponse)
async def get_song(song_id: int):
    song = next((s for s in songs if s["id"] == song_id), None)
    if song:
        return {"song": song}
    return {"error": "Song not found"}