# Build a RAG application over a SQL database

## Overview

In the [notebook](sql-rag.ipynb), we will see how to build a RAG application that allows a LLM to do question answering over a SQL database (or relational database).

At a high-level, the steps of the system are:

1. **Convert question to SQL query**: Model converts user's natural language question to a syntatically valid SQL query.
2. **Execute SQL query**: Model invokes a tool to execute the SQL query.
3. **Answer the question**: Model synthesizes an answer to the user's question using the database query results.

![Convert user's question to SQL](img/sql_usecase.png "Convert user's question to SQL")
**Figure 1**: Image from [LangChain tutorial](https://python.langchain.com/docs/tutorials/sql_qa/#architecture)

In the notebook, we will explore two ways of building the system. One using chains with LangChain and another using an agent with LangGraph.

The code in this notebook is adapted from the LangChain tutorial: [Build a Question/Answering system over SQL data](https://python.langchain.com/docs/tutorials/sql_qa).


## Project Directory Structure

Directory | Description
:--- | :---
`db` | Contains the sample database and the SQL script to re-create the sample database.
`examples` | Contains SQL examples used for few-shot prompting. Includes a notebook that shows how to convert SQL examples to JSON.
`prompts` | Contains prompt templates for the LLM
`img` | Contains images used in the notebook

## Setup

### Git

Clone this repository to your local computer by running:

```zsh
git clone https://github.com/TCLee/sql-rag
```

### Conda

1. You will need conda in order to install the required packages to run the notebook. [Installing conda](https://docs.conda.io/projects/conda/en/stable/user-guide/install/index.html).

2. Make sure the current working directory is this cloned project's directory:

   ```zsh
   cd /path/to/sql-rag
   ```
   
3. Create the environment from the 
   [`environment.yml`](environment.yml) file:

    ```zsh
    conda env create -f environment.yml -p ./env
    ```

    This will create a new environment in a subdirectory of the project directory called `env`, (e.g., `/path/to/sql-rag/env`)

4. Activate the environment: 

    ```zsh
    conda activate ./env
    ```

### Environment variables

This project makes use of 
[python-dotenv](https://github.com/theskumar/python-dotenv)
to load in the environment variables from a `.env` file.

Create a `.env` file in the root directory of this cloned repository
(e.g., `/path/to/sql-rag/.env`). Fill in the following with your own API keys:

```Dotenv
# Google Gemini API
GOOGLE_API_KEY="your-google-secret-key"

# Optional. Recommended to see what's going on 
# under the hood of LangGraph and LangChain.
LANGSMITH_API_KEY="your-langsmith-secret-key"
LANGCHAIN_TRACING_V2="true"
LANGCHAIN_PROJECT="SQL RAG"
```

#### Google Gemini
The LLM that we will use in the notebook is Google's [Gemini 1.5 Flash](https://ai.google.dev/gemini-api/docs). It is fast and it offers a generous free tier for us to play around with.

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
[`sql-rag.ipynb`](sql-rag.ipynb) 
and follow the instructions there.