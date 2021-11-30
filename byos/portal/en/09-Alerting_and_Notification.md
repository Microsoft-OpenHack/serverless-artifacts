# Alerting and notification

## Background

Best For You Organics Company's management would like to be alerted when
there's a high number of bad reviews for a specific ice cream. They are
hoping they can take advantage of the system you created earlier to react
to business related information that is raised from custom telemetry in
your code.

## Challenge

Your first challenge is to update the `CreateRating` function and put the
`userNotes` field through a sentiment analysis service. You should then
use the result of the sentiment analysis to add an extra field,
`sentimentScore`, to the JSON before saving to the database, and use custom telemetry to record information about the negative review.  Of particular interest for this challenge will be ratings that contain any sentences which receive a `negative` sentiment result having a score of 0.7 or greater.  

To start receiving automated ratings, make a post call to the
`/team/registerRatingEndpoint` method of the OpenHack API System.  

* OpenHack API OpenUI Definition:
[Openhack Swagger](https://petstore.swagger.io/?url=https://serverlessohmanagementapi.trafficmanager.net/api/definition)

Your second challenge is to implement a solution to generate an email alert
to your coach whenever at least five bad ice cream reviews with a `negative` sentiment result greater than or equal to 0.7 on any sentences have been received in the past five minutes. The email should contain the bad reviews information, or a link to the information about the reviews.

> Hint: This is five individual reviews containing at least one sentence with a negative sentiment score, not five total sentences in one or more reviews.  The threshold should be greater than or equal to five negative reviews in the previous five minutes.

## Success Criteria

* `GetRating` and `GetRatings` should return the `sentimentScore` field
with the sentiment analysis result from the `userNotes` for new ratings
created

* Your coach should receive an email with an alert containing information
about the bad reviews after five are created within five minutes by the
automated system

## References

* [How to detect sentiment in Text Analytics](https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-sentiment-analysis)

* [Monitor Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-monitoring)

* [Log alerts in Azure Monitor - Alerts for Application Insights](https://docs.microsoft.com/azure/monitoring-and-diagnostics/monitor-alerts-unified-log)

## Progress Diagram

![Alerting and notification progress diagram](https://serverlessoh.azureedge.net/public/alerting-and-notification-progress-diagram.jpg)
