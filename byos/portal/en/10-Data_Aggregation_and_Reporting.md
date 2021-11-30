# Putting it All Together

## Background

As Best For You Organics Company (BFYOC) now has data from customer reviews, distributor
orders, and POS sales for the new fruit flavored ice cream line, the
product managers would like to know how the new line of ice creams are
doing.

## Challenge

Your challenge is to work on a solution that monitors and forwards the
reviews, distributor orders, and POS sales data to an event-processing
engine that will then, every 5 minutes, summarize the following:

* A list of ice creams based on total distributor orders total sales,
from highest to lowest
* A list of ice creams based on total POS sales, from highest to lowest
* The average sentiment analysis value for each ice cream

Aggregate the data for each 5 minute tumbling window and then use that
data to generate a report for your manager (your coach) with these insights.

## Success Criteria

* Demonstrate to your coach how you implemented the solution

* The coach should have access to a report that includes all the required
info as per the Challenge section.

* Infrastructure Bonus - If your team has an IaC focused member, demonstrate how the new services can be deployed using the code, processes and pipeline in place.

## References

* [What is Stream Analytics?](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-introduction)

* [Stream data as input into Stream Analytics](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-define-inputs)

* [Query examples for common Stream Analytics usage patterns](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-stream-analytics-query-patterns)

* [Azure Stream Analytics output to Azure Cosmos DB](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-documentdb-output)

* [Working with the change feed support in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/change-feed)

## Progress Diagram

![Final progress diagram](https://serverlessoh.azureedge.net/public/final-progress-diagram.jpg)
