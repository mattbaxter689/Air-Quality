# Air Quality

This project started out as me wanting to take something on to prove to myself that I am fully capable as 
a data practitioner to build something on this scale. While this project seems small compared to what is actually performed in industry,
I did each and every single one of these steps myself which would typically involve multiple disciplines in order to get it 
to the state it is currently in. I'm incredibly proud of what I have accomplished, and I definitely learned more about myself as a developer,
as well as tools used in industry. Because of this, I've gained far more confidence in my abilities than I have in any other project I have ever
worked on. There were many days of frustration, but this final product has been so incredibly worth it.

The main inspiration for this project comes from both my wife and I having sensitive allergies, especailly during the early to mid-summer.
Unfortunately, pollen information is not available for my area from the API that was used, however, I spun this project to instead focus on modelling
air quality. Though allergies are annoying, modelling air quality has significant benefits, especially for those who are at risk of health issues or concerns due to poor air quality. As global warming increases, the resulting forest fires in Western Canada are becoming far more frequent. As that air travels across the country, it can greatly affect the air quality, even across the country. Having a tool like this can inform at-risk populations and when to take precautions to avoid any other harm.

While I have worked on some pieces of this project more in-depth than others, I wanted to fully build something end-to-end myself for two reasons:
1) To explore other topics I'm not as familiar with and gain a better understanding of how to perform said tasks
2) To help myself understand technologies that I have wanted to use, but never got the chance to

Since starting this project, I can comfortably say I have exceeded my expectations of myself when first planning.

My initial design split each component of this project into separate repositories, so as to separate the code
from each portion. The main reasoning for this is that each component covers a different discipline in 
the data world. The table below lays out the various pieces that make up this entire project, as well
as the discipline the repository focuses on

| Repo Name  | Discipline  |  Repo Link  |  Description |
|:-:|:-:|:-:|---|
|  Air Quality Infrastructure | DevOps/MLOps  | [Infra](https://github.com/mattbaxter689/Air-Quality-Infrastructure)  | Infrastructure for deploying in cloud  |
|  Rust Air Quality |  Data Engineering | [Rust](https://github.com/mattbaxter689/Rust-Air-Quality)  | Data ingestion with Rust and Kafka  |
| Air Quality LSTM  | ML Engineering  | [Model](https://github.com/mattbaxter689/Air-Quality-LSTM)  | Model fitting and logging with PyTorch  |
| Air Quality API  | MLOps  | [API](https://github.com/mattbaxter689/Air-Quality-API)  | FastAPI to host prediction for model  |
|  DBT Air Quality | Data Analysis  | [DBT](https://github.com/mattbaxter689/DBT-Air-Quality)  | Using dbt for some simple transformations  |
| Prefect Air Quality  | All of the Above  |  [Prefect](https://github.com/mattbaxter689/Prefect-Air-Quality) | Using Prefect to trigger model training and dbt model refresh  |

Each repository also contains it's own individual documentation about the resulting code contained, as well as some instructions on how the process works. This documentation is more in-depth to the specific task, which should better answer any questions.

## Note: uv Package Manager
Something I wish to highlight is that for the dbt, pytorch model, and API code,
I make use of the uv Python package manager. This has been an excellent tool and
is fantastic at setting up and maintaining my Python environments. The only
reason it is not part of the prefect code is the prefect Docker image being used
just needs a few additional packages added, and I did not want to go through the
headache of configuring uv in that environment.

### Future Enhancements:
For this project, aside from a few additional pieces that I need to finish, this project is in a state I will call "finished". 
I don't want to mark it as fully complete because there are some enhancements or things that I would eventually like to add as time
goes on. I have definitely exceeded from what I initially planned to do, and I'm so proud of myself for putting together a project
like this. It took many weeks to be able to even get to this point, so it is a great feeling knowing that I already got it here. That being said,
as time goes on and I revisit this project, there are some topics I would like to explore. Some of them are below, along with some small pieces that need to be added to meet my goal for now.

#### torch_weather
 - [ ] Warm vs cold starts: Depending on the amount of drift detected (from
   evidently) warm or cold start the model. Cold start on everything, warm start
   on 120 days of data using previous model parameters. Log parameters of final
   model, and inject variable to image to use

 #### rust_kafka
- [ ] Add a generic retry function for API and database inserts

#### dbt_weather
- [ ] Add lag models comparing previous time stamps data
- [ ] add models to flag if delta meets threshold
- [ ] Add API logs to grafana application

#### weather_prefect
- [ ] add cold start flow on a weekly/monthly basis