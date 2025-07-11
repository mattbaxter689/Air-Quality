# DBT Weather

This dbt portion of the project is just for some simple transformations to apply. I want to expand my understanding of dbt, which is why some transformations may seem redundant or unused. It is simply for me to expand my understanding of the technology as a whole. Also, I want to expand upon this entire project as time goes on, which includes the models used, and the extent of which I use them.

For the future I'd like to improve the documentation of the models including:
- model ownership
- model tags

I'd also like to add other models including:
- models reporting change in pollutant levels (delta) from one hour to the next, day to day, etc
- Adding flags when deltas reach a certain threshold to raise pollutant level flags
- Create my train/val/test splits automatically with dbt models, rather than performing that portion with python

Overall, I'm using this project in tandem with everything else to improve upon my skills and develop a deeper understanding of technologies used in industry more often.

### Why dbt?

I wanted to use dbt for 2 main reasons:
1. Because dbt is a fantastic tool that makes data modelling so incredibly easy
2. I wanted to gain more experience with a more advanced dbt project compared to what I have touched previously. 

My past experience with dbt has been setting up some simple data models to explore data transformations. With this project, I wanted to explore a more "filled out" dbt project and understand on a better level what larger dbt projects look like. For this project, I've included some more simple transformations as a result, albeit they are more in-depth compared to what I have used before. Nevertheless, there are still things that I wish to improve upon with this project, including executing other dbt models like lag differences, etc. 

For a beginning iteration, I am overally fairly happy with how things have turned out here, and I have learned more and gained a better understading overall of how to structure these dbt projects

### Grafana

To incorporate a visual component to this project, and to explore the distributions and data that is part of this, I have set up a Grafana dashboard to explore these dbt models, as well as time series data. It's especially important when creating the models that I actually have something to show. I've included an example image below showing some of the data contained in the dashboard. Like above, I wish to expand upon this as time goes on, inluding other dbt models as part of this entire process.

Eventually, I would also like to add Loki and Promtail to this project, as well as the pytorch API, so that we can observe logs for individual requests, and create dashboards for log data to get a better understanding of API performance. Overall, these visualizations just provide a better story about the data itself, and API performance as a whole