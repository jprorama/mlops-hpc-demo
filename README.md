This is a simple project to demo a basic MLOps pipeline for HPC.

## What is MLOps

MLOps is a process of bringing disciplined software development practices to the art of Machine Learning development.

MLOps builds on the ideas of DevOps and extends them to address model and data tracking requirements of ML.  The focus of DevOps is about tracking changes to the code, providing reliable tests so you can tell when something breaks, and using those foundations to automate as much of the tedious work of development.  That work includes checking your code on each commit or merge to make sure it doesn't break any of the expected functionality.  This is known as continuous integration (CI).  

Once CI pipelines have matured, projects might move to continuous delivery or deployment (CD).  For example, a project that delivers a containerized version of an application might automatically deploy a binary every time features are merged to the main branch so developers can easily work with the latest release. These two processes together are called CI/CD, whether you do either one or both.

MLOps has all of these requirements too, so MLOps practicioners use the same solutions that DevOps does. A way to think about how MLOps extends DevOps is that DevOps is focused on ensuring the defined code paths that are built are hightly reliable.

To achieve this same reliability for MLOps we need add our data and model information into the workflow, since ML development is about learning a code path via training against a specific data set.    In order to ensure the reliabiliy of learned code paths we need to track the inputs and results of training in addition to the code that develops the model.  The goal of MLOps is to know that the last changes to the code (or data) maintains the expected performance of the code (ie. passes all the defined tests).

There are many solutions for MLOps. Most cloud platforms are hard at work building services to run your MLOps pipelines (and, sometimes, drain your wallet).  We can look at some of the docs here.  They all do a good job of explaining the concepts and provide nice pictures as guides.

* [Blog post on MLOps](https://medium.com/illumination/introduction-to-mlops-f877ccf10db1)
* [NVIDIA MLOps Overview Blog post](https://blogs.nvidia.com/blog/2020/09/03/what-is-mlops/)
* [DataBrick MLOps Intro](https://databricks.com/glossary/mlops)
* [MLops Docs for GCE](https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning)
* [MLOps with Azure Machine Learning](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/ai/mlops-python)
* [MLOps Workload orchestrator on Amazon](https://aws.amazon.com/solutions/implementations/mlops-workload-orchestrator/) 


Some of the tools are tied to specific technologies like Kubernetes. Some are tied to specific cloud platforms.

The [MLFlow tool](https://mlflow.org/) from DataBricks is a nice exception that is designed to work across technologies no matter what your platform is.  It can work with cloud or Kubernetes.  

Unfortunately, all these tools are very cloud native.  They map well to cloud abstactions for compute and data.

They don't map very well (at all) to traditional batch computing.  There is some interesting work going on as part of the [Exascale Computing Project (ECP)](https://ecp-ci.gitlab.io/docs/admin.html) to build hooks for GitLab via gitlab runners.  This requires a GitLab platform with those runners installed. That requires control of your GitLab (afaik).

What do you do if you are a lowly HPC user that just has slurm and a hankering for MLOps?

You start to build your own...

## Getting Started

We are building on top of the lastest Anaconda3, version 2021.11 currently.
If you are on a cluster you might be able to load this easily with:

    module load Anaconda3/2021.11

We'll want a custom environment in for our own modules. Let's call it "mlops":

    module load Anaconda3/2021.11
    conda create -y --name mlops
    conda activate mlops
    conda install -y numpy scipy scikit-learn pandas
    conda install -y ipykernel
    python -m ipykernel install --user --name mlops --display-name "Python (mlops)"
    conda install -y -c conda-forge papermill
   
  