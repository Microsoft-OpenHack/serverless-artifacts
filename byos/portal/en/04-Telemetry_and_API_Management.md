# System telemetry and API Management

## Background

Now that the Best For You Organics (BFYOC) API is complete, they want to start tracking telemetry from their API calls to be able to monitor the solution. After all, if you can't measure it, you can't improve it!

BFYOC would also like to begin exposing their APIs. They want to ensure the the APIs use consistent URL. They also want them exposed as different suites of APIs. They would like to have a different suite of APIs  exposed to the mobile application, internal business users running reports and external partners. They also want to ensure that their mobile users receive priority access to those APIs by throttling requests from both internal business users and external partners.

## Telemetry

The first part of this challenge is to work as a team to enable telemetry for the production Ratings API functions. BFYOC has requested a table derived from telemetry that displays the following information about your Ratings functions:

* The number of times each function was run in the past hour

* The average duration of each function in that hour

* There should be one row for each of the three Ratings functions your team created earlier

> **Hint**: Application Insights may take a few minutes before showing telemetry from your functions

## API Exposure

### Uniform URL

Next your team is to create a uniformly addressed version of the entire API. This includes the `GetUser`, `GetProduct` and `GetProducts` APIs that already existed, and all the production functions your team created: `CreateRating`, `GetRating`, and `GetRatings`. Your team should expose all of these operations under the same base URL, as they currently are under different base URLs.

### Product suites

Your team will now need to create 3 suites of APIs. One for each of the use cases: Mobile Application, Internal business users and External Partners. The team will need to configure the products so that only the required operations are exposed to the different product suites. Those requirements are as follows:

#### Mobile Applications

The Mobile Application requires access to all of the APIs. Each of them is required for different areas of the application's UX. So the operations that need to be configured for this product suite are as follows:

* GetUser
* GetProduct
* GetProducts
* CreateRating
* GetRating
* GetRatings

#### Internal business users

The Internal business users use the APIs for reporting purposes. They need access to the product and rating information but shouldn't be using the user operation or be able to create ratings. So the operations that should be exposed to this product suite are as follows:

* GetProduct
* GetProducts
* GetRating
* GetRatings

#### External Partners

The External Partners use case is to be able to see products that BYFOC has to offer, so should only have the product operations exposed to them. So this product suite should only have the following operations exposed to them:

* GetProduct
* GetProducts

### Throttling

Finally, we need to ensure that our Mobile Application users are given priority over use of these APIs. We need to create some throttling on the operations exposed to the Internal business users and the External Partners.

Your team will need to create policies that ensure that the Internal business users do not make more than 10 calls within a 60 second time period on the operations that are exposed through this product suite.

The External Partners should also be throttled, but shouldn't be throttled as greatly. The operations exposed to our partners should be limited to 15 calls per 60 seconds.

No need to store the results in a data store, on screen display of the results is sufficient

The mobile applications users shouldn't have any throttling configured on the operations exposed to them.

## Success Criteria

* Demonstrate to your coach the implementation of how to check the total number of times and the average duration of each function for the past hour based on telemetry. The results should be displayed as a table, in the same result set, and have one row for each of the three production Ratings API functions you created in the previous challenge.

    > No need to store the results in a data store, on screen display of the results is sufficient

* Demonstrate to your coach the implementation of exposing a uniform API under the same base URL for all functions

* Demonstrate to your coach the configuration of the 3 different product suites and the operations exposed to each of them.

* Demonstrate to your coach the implementation of the rate limiting requirements. The results should have different policies configured on the Internal business users product suite then on the External Partners product suite. There should be no throttling configured on the Mobile Applications product suite.

## References

* [Monitor Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-monitoring)
* [Azure Monitor Log Queries](https://docs.microsoft.com/azure/azure-monitor/log-query/log-query-overview)
* [Azure API Management Overview](https://docs.microsoft.com/azure/api-management/api-management-key-concepts)
* [Azure API Management Tiers](https://docs.microsoft.com/azure/api-management/api-management-features)
* [Azure API Management Policies](https://docs.microsoft.com/azure/api-management/set-edit-policies)
* [Azure API Management Access Restriction Policies](https://docs.microsoft.com/azure/api-management/api-management-access-restriction-policies)

## Progress Diagram

![System telemetry and API Management progress diagram](https://serverlessoh.azureedge.net/public/system-telemetry-and-api-management-progress-diagram.jpg)

### Bonus - Infrastructure as Code

Participate in discussion with your team around the configuration and managment of the APIs. Think about what components of the API Management solution that should be reflected as Infrastructure.

* [Azure API Management Resource Kit](https://github.com/Azure/azure-api-management-devops-resource-kit)
