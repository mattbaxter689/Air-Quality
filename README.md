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
to pollen information should it become available. I have also worked with this
type of flow in separate stages cross different projects, but I wanted to set
something up from end-to-end to prove to myself that I can do it, since imposter
syndrome can bog you down.

Each repository will contain a separate README file that will dive into what it
handles and how to run everything.

## Note: uv Package Manager
Something I wish to highlight is that for the dbt, pytorch model, and API code,
I make use of the uv Python package manager. This has been an excellent tool and
is fantastic at setting up and maintaining my Python environments. The only
reason it is not part of the prefect code is the prefect Docker image being used
just needs a few additional packages added, and I did not want to go through the
headache of configuring uv in that environment.

### Future Enhancements:
Now, just because this project is "finished" does not mean I am going to leave
it alone from here on. Instead, I want to use this project as a focal point, and
continuously improve upon it as time goes on. It is technically "finished" from
my initial designs for the project, however there are improvements I want to
make that didn't fit in the initial scope of the project. For now, I will list
them hear for each directory

#### torch_weather
 - [ ] Including real-time predictions using kafka streaming. Will result in
   backfilling predictions with actual data to compare as time goes on
 - [ ] Warm vs cold starts: Depending on the amount of drift detected (from
   evidently) warm or cold start the model. Cold start on everything, warm start
   on 120 days of data using previous model parameters. Log parameters of final
   model, and inject variable to image to use
 - [ ] multi-output LSTM rather than single target.

 #### rust_kafka
- [ ] Add persistable trait for the database insert functionality
- [ ] Add a generic retry function for API and database inserts
- [ ] Add streaming for 12 past hours to predict next hours AQI

#### dbt_weather
- [ ] Add lag models comparing previous time stamps data
- [ ] add models to flag if delta meets threshold
- [ ] Add API logs to grafana application

I also want to look to potentially include github actions, but want to finish
everything else before I jump to this. Although, time will tell. 

Another *VERY* important thing for me to remember is to also move everything out
of a mono repo like this. Instead, It should all be their own individual repo's
for CI/CD to work properly. My plan is to use submodules/trees to link this repo
to the sub repo's
