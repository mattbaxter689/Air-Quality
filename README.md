# Rusty-Weather

This project is an accumulation of me wanting to expand my horizons and
familiarize myself with technologies I do not necessarily get exposed to while
working my regular dayjob. There are fairly lofty goals for what this project
entails, but I'm hoping that over several weeks, I will be able to implement the
main goal of this project, while being able to take it a step further down the
line.

This is also a good time to remind myself to include a flow diagram as part of
this application. The subdirectories here do the following:

The inspiration for this project comes from my wife and I both having sensitive
allergies, with the goal to predict air quality, and hopefully one day, expand
to pollen information should it become available.

### Rust Kafka
This directory has a focus on streaming data from the Open-Meteo historical air
quality API to a Timescale database instance using Rust and Kafka. It streams
data from January 1, 2023 (As this is when historical data was returning actual
information) to the current date. I'm fine with the state it is in now, however
I would like to do the following eventually:
- Add logging to the codebase rather than print statements
- Improve code readability and deduplicate functionality by using generics and
  traits to implement retry functionality on API requests and sql INSERT
  statements, along with specifying default configurations for Kafka setup, etc


### Upon Completion Enhancements
Once I am satisfied with the main goal of this project, I'll look to other ways
to enhance the application. Some that come to mind are:
- DBT for data modelling and transformation
- Grafana to view historical time-series data for air quality
- Dagster or prefect to orchestrate the code of the various repositories
