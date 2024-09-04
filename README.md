# Multi-Agent Collaboration

## Overview

A single agent can usually perform well using a small set of tools to solve a specific problem. However, even powerful models like GPT-4 may struggle when given many different tools to solve a complex problem.

One way to approach complicated tasks is through a _"divide-and-conquer"_ approach. Create a specialized agent for each task and route tasks to the correct _"expert"_.

In this [notebook](multi-agent-collab.ipynb), we will see how two agents, each given different tools, can work together to solve a problem that requires the use of all available tools.

The code in the notebook is adapted from the LangGraph tutorial: 
[Multi-agent Collaboration](https://langchain-ai.github.io/langgraph/tutorials/multi_agent/multi-agent-collaboration/).


## Setup

### Git
Clone this repository to your local computer by running:

```zsh
git clone https://github.com/TCLee/multi-agent-collab
```

### Conda
1. You will need conda in order to install the required packages to run the notebook. [Installing conda](https://docs.conda.io/projects/conda/en/stable/user-guide/install/index.html).

2. Make sure the current working directory is this cloned project's directory:

   ```zsh
   cd /path/to/multi-agent-collab
   ```
   
3. Create the environment from the 
   [`environment.yml`](environment.yml) file:

    ```zsh
    conda env create -f environment.yml -p ./env
    ```

    This will create a new environment in a subdirectory of the project directory called `env`, (i.e., `project-dir/env`)

4. Activate the environment: 

    ```zsh
    conda activate ./env
    ```

### Environment variables
This project makes use of 
[python-dotenv](https://github.com/theskumar/python-dotenv)
to load in the environment variables from a `.env` file.

Create a `.env` file in the root directory of this cloned repository
(i.e., `project-dir/.env`):

```Dotenv
# Google Gemini API
GOOGLE_API_KEY="your-google-secret-key"

# Optional. Recommended to see what's going on 
# under the hood of LangGraph and LangChain.
LANGSMITH_API_KEY="your-langsmith-secret-key"
LANGCHAIN_TRACING_V2="true"
LANGCHAIN_PROJECT="Multi-Agent Collaboration"
```

Fill it in with your own API keys.

#### Google Gemini
The LLM that we will use in the notebook is Google's **Gemini 1.5 Flash**. It is fast and it offers a generous free tier for us to play around with.

To use the Gemini API, you'll need an API key. If you do not already have one, create a key in Google AI Studio.

[Get an API key](https://makersuite.google.com/app/apikey)


#### (Optional) LangSmith
Many of the applications you build with LangChain will contain multiple steps with multiple invocations of LLM calls. As these applications get more and more complex, it becomes crucial to be able to inspect what exactly is going on inside your chain or agent. The best way to do this is with [LangSmith](https://smith.langchain.com/).


### Jupyter Notebook

The conda environment includes an installation of [Jupyter Lab](https://jupyter.org/). Start Jupyter Lab from your terminal:

```zsh
jupyter lab
```

In Jupyter Lab, open the notebook 
[`multi-agent-collab.ipynb`](multi-agent-collab.ipynb) 
and follow the instructions there.