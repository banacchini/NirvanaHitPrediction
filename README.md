# Bayesian Hit Prediction: Nirvana Discography Case Study

![Nirvana Picture](https://wallpapersok.com/images/hd/iconic-nirvana-band-in-the-glory-days-xevpxnmkenzkqhse.jpg)

This case study explores the use of Bayesian logistic regression to predict hit songs based on the audio features of Nirvana's discography. By analyzing tracks from Nirvana's iconic albums and extracting data from Spotify, the model aims to identify key attributes that contribute to the success of a song.

## Objective
The goal is to determine which audio features, such as **danceability**, **tempo**, and **valence**, are most predictive of a song becoming a hit. This analysis was performed using Bayesian regression models and focused on songs from Nirvana's four studio albums.

## Dataset
The dataset contains audio features for songs from Nirvana's studio albums:
- **Bleach** (1989)
- **Nevermind** (1991)
- **Incesticide** (1992)
- **In Utero** (1993)

### Key Attributes:
- **Danceability**: How suitable a track is for dancing (0.0 to 1.0 scale).
- **Energy**: A measure of intensity and activity (0.0 to 1.0 scale).
- **Tempo**: Beats per minute (BPM).
- **Valence**: The positiveness conveyed by a track (0.0 to 1.0 scale).
- **Speechiness**, **Acousticness**, **Loudness**, and more.

![Danceability vs Hit](https://github.com/banacchini/NirvanaHitPrediction/blob/main/danceabilityPlot.png)

### Target Variable:
- **Hit or Not**: A song is classified as a "hit" if it has more than **150 million streams** on Spotify.

## Methodology
1. **Data Preprocessing**:
   The dataset was cleaned, and a binary "hit" variable was created based on the number of streams.

2. **Exploratory Data Analysis**:
   Visualizations were created to explore relationships between features (e.g., higher **danceability** tends to correlate with hits, while hit songs typically have lower **tempo** and **valence**).

3. **Bayesian Logistic Regression**:
   Bayesian models were used to predict the likelihood of a song being a hit. The analysis was conducted using the **MCMCpack** library in R, which allowed for the estimation of model parameters.

4. **Hit Prediction**:
   The model was applied to predict the likelihood of two iconic grunge songs becoming hits:
   - **Nirvana - Smells Like Teen Spirit**
   - **Soundgarden - Black Hole Sun**

![Smells Like Teen Spirit Hit Probability Histogram](https://github.com/banacchini/NirvanaHitPrediction/blob/main/smellsLikeTeenSpiritHistogram.png)

## Results and Conclusions
### Key Findings:
- **Danceability**: Higher danceability correlates with hit songs.
- **Tempo**: Slower songs tend to be more popular in Nirvana's discography.
- **Speechiness**: Lower speechiness (fewer spoken word elements) correlates with a higher likelihood of a hit.
- **Valence**: Hit songs tend to have a lower, more melancholic emotional tone.

### Comparative Analysis:
The model predicted the hit probability for:
- **Smells Like Teen Spirit**: 9.4% chance of being a hit, despite its status as one of the biggest rock songs ever.
- **Black Hole Sun**: 29.6% chance of being a hit, suggesting that its audio features align better with the hit-predicting trends identified in the model.

### Conclusion:
The Bayesian model provided valuable insights into how certain audio features might predict the success of a song. However, music is inherently subjective, and other unmeasurable factors (like lyrics, cultural significance, and promotion) also play critical roles in a song's success. This study shows how audio data can offer trends but cannot fully capture the essence of what makes a hit song.

## Limitations:
- **Small Sample Size**: Only 54 songs were analyzed.
- **Focus on Audio Features**: Other important factors (e.g., lyrical content, marketing) were not included.

## Technologies Used:
- **RStudio**: For data analysis and Bayesian modeling.
- **Spotify API**: To gather audio features for each song.
- **MCMCpack**: For Bayesian logistic regression.

---

This case study sheds light on how data-driven models can provide insights into the trends behind hit songs but also reminds us that the magic of music is often beyond numbers.
