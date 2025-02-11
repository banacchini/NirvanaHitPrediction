# Load the dataset from CSV file
# Ensure the file is in the working directory or provide the full file path
data <- read.csv('nirvana_discography.csv', sep =';') 

# Attach the dataset to make column names accessible without referencing 'data$'
attach(data) 

# Display column names of the dataset
names(data) 

# Create a binary variable 'bin.hit' that classifies songs as hits (1) or non-hits (0)
# A song is considered a hit if it has more than 150 million streams
bin.hit = ifelse(data$streams > 150000000, 1, 0)

# Display the names of songs classified as hits
song_name[bin.hit == 1]


# Generate boxplots to visualize differences in audio features between hit and non-hit songs
boxplot(danceability ~ bin.hit, data = data, main="Danceability vs Hit Status", 
        xlab="Hit Status", ylab="Danceability", col=c("red", "green"))

boxplot(energy ~ bin.hit, data = data, main="Energy vs Hit Status", 
        xlab="Hit Status", ylab="Energy", col=c("red", "green"))

boxplot(loudness ~ bin.hit, data = data, main="Loudness vs Hit Status", 
        xlab="Hit Status", ylab="Loudness (dB)", col=c("red", "green"))

boxplot(speechiness ~ bin.hit, data = data, main="Speechiness vs Hit Status", 
        xlab="Hit Status", ylab="Speechiness", col=c("red", "green"))

boxplot(acousticness ~ bin.hit, data = data, main="Acousticness vs Hit Status", 
        xlab="Hit Status", ylab="Acousticness", col=c("red", "green"))

boxplot(tempo ~ bin.hit, data = data, main="Tempo vs Hit Status", 
        xlab="Hit Status", ylab="Tempo (BPM)", col=c("red", "green"))

boxplot(valence ~ bin.hit, data = data, main="Valence vs Hit Status", 
        xlab="Hit Status", ylab="Tempo (BPM)", col=c("red", "green"))


# Load the MCMCpack library for Bayesian logistic regression
library(MCMCpack) 

# Perform Bayesian logistic regression with initial parameters
bayes.logit <- MCMClogit(bin.hit ~ danceability + energy + 
                           speechiness + acousticness + valence + tempo, 
                         data = data, burnin = 1000, mcmc = 10000, thin = 1) 

plot(bayes.logit)
acf(bayes.logit)



# Run Bayesian logistic regression again with increased burn-in and iterations to improve accuracy
bayes.logit <- MCMClogit(bin.hit ~ danceability + energy + speechiness + 
                           acousticness + valence + tempo, 
                         data = data, burnin = 10000, mcmc = 150000, thin = 25)

plot(bayes.logit)
acf(bayes.logit)


# Create a refined model by selecting only the most significant predictors
bayes.logit2 <- MCMClogit(bin.hit ~ danceability + tempo + speechiness + 
                            valence, 
                          data = data, burnin = 10000, mcmc = 150000, thin = 25)

plot(bayes.logit2)
acf(bayes.logit2)




library(boot)


# Predict hit probability for "Smells Like Teen Spirit"
slts.linear = bayes.logit2[,1] + 0.502*bayes.logit2[,2] 
+ 116.761*bayes.logit2[,3] + 0.0564*bayes.logit2[,4] + 0.72*bayes.logit2[,5] 

# Convert logit output to probability using inverse logit function
slts.pred = inv.logit(slts.linear) 

# Compute the mean predicted probability of "Smells Like Teen Spirit" being a hit
mean(slts.pred) 

# Compute the 95% predictive interval (confidence range) for the hit probability
quantile(slts.pred, c(0.025, 0.975))

# Predict hit probability for "Black Hole Sun"
bhs.linear = bayes.logit2[,1] + 0.35*bayes.logit2[,2] + 
  105.435*bayes.logit2[,3] + 0.041*bayes.logit2[,4] + 0.147*bayes.logit2[,5] 

# Convert logit output to probability
bhs.pred = inv.logit(bhs.linear)

# Compute the mean predicted probability of "Black Hole Sun" being a hit
mean(bhs.pred) 

# Compute the 95% predictive interval for "Black Hole Sun"
quantile(bhs.pred, c(0.025, 0.975))
