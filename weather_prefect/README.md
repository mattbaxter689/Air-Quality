# Weather Prefect
This repository contains the necessary code to make use of prefect to run dbt
models on a schedule, along with automating checks on data drift for out PyTorch
pipeline.

### Why Use Prefect?
Having used Airflow and Dagster, I was curious to see how Prefect compared to
them in terms of ease of setup, use, etc. Based on setup and definition alone,
prefect definitely feels like the easiest to use by far. Being able to define my
flows as python components so easily made setup of the scheduling incredibly
easy. Airflow and Dagster are both great tools, there's just so many extra bits
that are there that I don't need for this project and wanted to keep separate
for ease of use.

### Running My Prefect Flows
For both my dbt and model training flows, I make use of the python Docker SDK.
For my specific use case, I wanted to keep the code for these tools separate
from Prefect to ensure that dependencies are left to their own projects. This
also allows me to have, what I feel, is greater flexibility in terms of
deployments. Now I don't need to package all of the necessary code into one
massive image and container. Since I chose my deployment this way, we need to
ensure that the Docker daemon is passed as a volume to the container. This way,
whenever I run my flows, it will run each flows docker image in a separate
container from my prefect instance, which I feel gives more control over changes
made to the code and images themselves.

### My dbt Flow
My dbt flow is quite simple: We fetch and run the latest dbt image build,
ensuring to pass along any required commands, environment variables, and
networks. We then wait for the container to finish running, before we fetch the
resulting logs, and show those resulting run logs on prefect. In case of any
errors, we log those results to the prefect console.

### My Data Drift Flow
My model drift flow has a few more steps that are needed in order to run my
model image. First, to check drift we compare data from the past 28 days with
the past 7 days. We use evidently to determine the severity of the drift, and
depending on the number of columns that are determined to have drifted, we
specify warm or cold starts for the model. Currently, if 2 or less columns have
drifted, we use a warm start. If more than 2 have drifted, we make use of a cold
start for the model. Currently, that check is commented out of the flow. The
reasoning for that is I need to implement this as part of my model training
image. I realised as I was creating the flows that constantly running cold
starts is not feasible, especially for models in production. Therefore, my plan
is to perform daily checks if warm vs cold starts are needed. Then, we will pass
the resulting variable to the docker image as an environment variable. This
image will then read this variable and use it to determine the training
strategy. This portion of the code still needs to be implemented in the model
training, however the idea behind it is there.

### Warm vs. Cold Starts
Now, since we are checking to perform either a warm vs cold start, there is a
caveat associated with this method. If we consistently perform warm starts,
eventually the model is going to overfit and forget all of the past information
as it would only be looking at the most up-to-date data available. Obviously,
this will have detrimental effects, as incorrect air quality predictions could
have severe risks for those suscpetible at worse air qualities. Therefore, I
will be adding a flow that performs a cold start on a weekly/monthly basis. This way,
throughout the week, there may be several warm starts, but the model will then
be fully trained on all available information. This should allow the model to
still generalize well to new data, without overfitting the model consistently,
giving us the best performance in terms of fitting and predictions throughout
the week
