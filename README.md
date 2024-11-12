# step-count-playlists

This app requests your step count from HealthKit upon first launch, fetches it and calculates the level of activity for the next hour. It's doing so by analyzing your averege step count for previous 7 days during the same time. Based on your maximum and minimum step counts throughout the week the app will define three different ranges of activity, and recommend you a playlist with proper audio tracks.

Trade-offs: no tests, no proper error handling, no handling of health authorization request decline.
Tests is especially important because of the steps count calculations complexity.
