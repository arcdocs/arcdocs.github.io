# Software Management

This guide asks a range of questions to consider when planning your software management. Each question has resources for more information.

_Examples are not an exhaustive list of possible options and many are Python-specific._

```{admonition} Checklist

- Use [version control](#version-control) for all of your code (e.g., [GitHub](https://github.com/)).
- Create one [environment](#package-management) for each project (e.g., [conda](https://docs.conda.io/projects/conda/en/latest/index.html)).
- Choose the most appropriate [method](#reproducibility) for capturing your computational environment.
- Capture your [computational environment](#package-management).
- [Share](#how-to-manage-the-software) your captured computational environment (along with your results/analysis) with a citable DOI and license.
- Ensure (at least) the key functionality is correct, by writing, and regularly running, [tests](#testing).
- Ensure (at least) the key functionality is [documented](#how-to-manage-the-software).

```

## Questions

### What is the software environment setup?

#### [Integrated Development Environment (IDE)](https://carpentries-incubator.github.io/python-intermediate-development/13-ides/index.html)

- e.g., [Jupyter Lab](https://jupyter.org/), [Visual Studio Code](https://code.visualstudio.com/), [PyCharm](https://www.jetbrains.com/pycharm/) (Python)

#### [Version control](https://the-turing-way.netlify.app/reproducible-research/vcs.html)

- [Code](https://carpentries-incubator.github.io/python-intermediate-development/14-collaboration-using-git/index.html)
  - e.g., [Git](https://git-scm.com/) ([GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Bitbucket](https://bitbucket.org/product)), [Subversion](https://subversion.apache.org/), [Mercurial](https://www.mercurial-scm.org/)
- [Data](https://the-turing-way.netlify.app/reproducible-research/vcs/vcs-data.html)
  - e.g., [Dolt](https://github.com/dolthub/dolt) ([DoltHub](https://www.dolthub.com/)), [Git Large File Storage (LFS)](https://git-lfs.github.com/), [Datalad](https://www.datalad.org/), [git-annex](https://git-annex.branchable.com/)
- Resources
  - [Version control (The Alan Turing Institute)](https://alan-turing-institute.github.io/rse-course/html/module04_version_control_with_git/04_00_introduction.html)

#### [Reproducibility](https://the-turing-way.netlify.app/reproducible-research/reproducible-research.html)

##### Package management

- User-level package management systems
    - e.g., [conda](https://docs.conda.io/projects/conda/en/latest/index.html), [spack](https://spack.readthedocs.io/en/latest/)
- [Virtual environments](https://carpentries-incubator.github.io/python-intermediate-development/12-virtual-environments/index.html)
  - e.g., Python: [pip](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/#installing-packages-using-pip-and-virtual-environments) and [venv](https://docs.python.org/3/library/venv.html), [virtualenv](https://virtualenv.pypa.io/en/latest/), [pipenv](https://pipenv.pypa.io/en/latest/), [poetry](https://python-poetry.org/)
  - [binder](https://mybinder.readthedocs.io/en/latest/index.html) ([guide](https://the-turing-way.netlify.app/reproducible-research/renv/renv-binder.html)), [conda-store](https://conda-store.readthedocs.io/en/latest/)

##### Entire computational environment

- [Containers](https://the-turing-way.netlify.app/reproducible-research/renv/renv-containers.html) ([guide](https://arc.leeds.ac.uk/Techtalks/techtalk-containers/#/scriptable-virtual-environments-with-containers))
  - e.g., [Singularity](https://apptainer.org/user-docs/master/) ([guide](https://the-turing-way.netlify.app/reproducible-research/renv/renv-containers.html#singularity)), [Docker](https://www.docker.com/), [repo2docker](https://repo2docker.readthedocs.io/en/latest/)
  - Manage and deploy containers e.g., [Kubernetes](https://kubernetes.io/)
- [Virtual machines](https://the-turing-way.netlify.app/reproducible-research/renv/renv-virtualmachine.html)
  - e.g., [Vagrant](https://www.vagrantup.com/) ([guide](https://arc.leeds.ac.uk/Techtalks/techtalk-vagrant/#/title-slide)), [VirtualBox](https://www.virtualbox.org/)

##### Workflow management

- e.g., [SnakeMake](https://snakemake.readthedocs.io/en/stable/), [Luigi](https://luigi.readthedocs.io/en/stable/), [Nextflow](https://www.nextflow.io/docs/latest/singularity.html) (with Singularity), [Make](https://the-turing-way.netlify.app/reproducible-research/make.html), [Research Compendium](https://the-turing-way.netlify.app/reproducible-research/compendia.html#), [protocols.io](https://www.protocols.io/), [Ploomber](https://ploomber.io/)

##### Resources

- [Reproducible environments (The Turing Way)](https://the-turing-way.netlify.app/reproducible-research/renv.html)
- [Reusable Code (The Turing Way)](https://the-turing-way.netlify.app/reproducible-research/code-reuse.html)
- [Tools for Reproducible Research](https://arc.leeds.ac.uk/Techtalks/techtalk-OpenLunch/#/title-slide)
- [Reproducible research (CodeRefinery)](https://coderefinery.github.io/reproducible-research/)
- [An Imperfect Guide to Imperfect Reproducibility, Gabriel Becker](https://gmbecker.github.io/MayInstituteKeynote2019/outline.html)

### How will software correctness be verified?

#### [Testing](https://the-turing-way.netlify.app/reproducible-research/testing.html)

- e.g., [pytest](https://docs.pytest.org/en/6.2.x/) (Python), [unittest](https://docs.python.org/3/library/unittest.html) (Python), [NumPy testing](https://numpy.org/doc/stable/reference/testing.html) (Python)
- Various [levels](https://softwaretestingfundamentals.com/software-testing-levels/) (when), [types](https://softwaretestingfundamentals.com/category/types/) (what), and [methods](https://softwaretestingfundamentals.com/software-testing-methods/) (how)
- [Debugging](https://alan-turing-institute.github.io/rse-course/html/module05_testing_your_code/05_05_using_a_debugger.html)
  - [pdb](https://docs.python.org/3/library/pdb.html) (Python)
- [Mocking](https://alan-turing-institute.github.io/rse-course/html/module05_testing_your_code/05_04_mocking.html)
- [Refactoring](https://alan-turing-institute.github.io/rse-course/html/module07_construction_and_design/07_03_refactoring.html)
  - [Design (objects)](https://alan-turing-institute.github.io/rse-course/html/module07_construction_and_design/07_04_object_oriented_design.html), [Classes](https://alan-turing-institute.github.io/rse-course/html/module07_construction_and_design/07_05_classes.html#)
- Resources
  - [Software testing fundamentals](https://softwaretestingfundamentals.com/)
  - [Testing (The Alan Turing Institute)](https://alan-turing-institute.github.io/rse-course/html/module05_testing_your_code/05_00_introduction.html)

#### [Continuous integration (CI)](https://the-turing-way.netlify.app/reproducible-research/ci.html)

- e.g., [GitHub Actions](https://github.com/features/actions) ([Guide](https://lab.github.com/githubtraining/github-actions:-continuous-integration)), [Travis CI](https://travis-ci.org/), [GitLab CI](https://docs.gitlab.com/ee/ci/), [Jenkins](https://www.jenkins.io/), [Azure Pipelines](https://azure.microsoft.com/en-us/services/devops/pipelines/), [Circle CI](https://circleci.com/)

#### [Code quality](https://the-turing-way.netlify.app/reproducible-research/code-quality.html)

- Formatting
  - e.g., [Black](https://black.readthedocs.io/en/stable/) (Python)
- Style
  - e.g., [PEP 8](https://www.python.org/dev/peps/pep-0008/) (Python), [Flake8](https://flake8.pycqa.org/en/latest/) (Python), [NumPy](https://numpydoc.readthedocs.io/en/latest/format.html#) (Python), [Google Style Guides](https://google.github.io/styleguide/)
- Static code analysis ([linting](https://the-turing-way.netlify.app/project-design/code-styling.html))
  - e.g., [Pylint](https://pylint.pycqa.org/en/latest/) (Python), [autopep8](https://github.com/hhatto/autopep8) (Python), [Mypy](https://mypy.readthedocs.io/en/stable/introduction.html) (Python)

#### [Code review](https://the-turing-way.netlify.app/reproducible-research/reviewing.html)

- e.g., [Codacy](https://www.codacy.com/), [CodeFactor](https://www.codefactor.io/)
- Code coverage
  - e.g., [codecov](https://about.codecov.io/), [Coveralls](https://coveralls.io/)

### How to manage the software?

- Project structure
  - e.g., [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/) ([Data Science](https://github.com/drivendata/cookiecutter-data-science), [Jupyter Book](https://github.com/executablebooks/cookiecutter-jupyter-book), [EasyData](https://github.com/hackalog/easydata))
- Share, [publish](https://www.software.ac.uk/which-journals-should-i-publish-my-software), and [release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository)
  - [Citable](https://the-turing-way.netlify.app/communication/citable.html) releases (with DOI, Digital Object Identifier)
    - e.g., [Zenodo](https://zenodo.org/) ([guide](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content)), [Open Science Framework](https://osf.io/), [FigShare](https://figshare.com/), [Dryad](https://datadryad.org/stash)
  - Executable environment
    - e.g., [Binder](https://mybinder.readthedocs.io/en/latest/), [BinderHub](https://binderhub.readthedocs.io/en/latest/index.html)
- [Documentation](https://www.software.ac.uk/blog/2019-06-21-what-are-best-practices-research-software-documentation)
  - e.g., [Jupyter Book](https://jupyterbook.org/intro.html), [Read the Docs](https://readthedocs.org/), [Sphinx](https://www.sphinx-doc.org/en/master/), [nbdev](https://nbdev.fast.ai/), [fastdoc](https://fastai.github.io/fastdoc/)
  - Publish online using [GitHub Pages](https://pages.github.com/) (for a [Jupyter Book](https://jupyterbook.org/start/publish.html))
- {ref}`Licensing <software_licensing>`
- [Issue tracking](https://carpentries-incubator.github.io/python-intermediate-development/43-assessing-software-suitability-improvement/index.html)
- Security
  - e.g, GitHub [Workflows](https://lab.github.com/githubtraining/securing-your-workflows) and [Essentials](https://lab.github.com/githubtraining/security-strategy-essentials)

### Training

- [SWD3: Software development practices for Research](https://arc.leeds.ac.uk/training/courses/swd3/), Research Computing, University of Leeds.
- [SWD7: Introduction to reproducible workflows in Python](https://arc.leeds.ac.uk/training/courses/swd7/), Research Computing, University of Leeds.
- [Intermediate Research Software Development in Python](https://carpentries-incubator.github.io/python-intermediate-development/), The Carpentries.

## Other general resources

- [Open Research (Library)](https://library.leeds.ac.uk/info/1406/researcher_support/199/open_research)
- [Software Carpentry](https://software-carpentry.org/)
- [CodeRefinery](https://coderefinery.org/)
- [UK Reproducibility Network](https://www.ukrn.org/)
- [Versioning (UK Data Service)](https://ukdataservice.ac.uk/learning-hub/research-data-management/format-your-data/versioning/)

## Examples

- [SHAP (SHapley Additive exPlanations)](https://github.com/slundberg/shap)
    - Version control with GitHub
    - Continuous integration with GitHub Actions, Travis CI
    - Capture and share project environment via conda or pip
    - MIT license
    - Documentation with examples
    - Tests with pytest
    - Reproducible via Binder
- [TPOT (Tree-based Pipeline Optimization Tool)](https://github.com/EpistasisLab/tpot)
    - Version control with GitHub
    - Continuous integration with GitHub Actions, Travis CI, AppVeyor
    - Capture and share project environment via conda or pip
    - LGPL-3.0 license
    - Documentation with examples
    - Tests with pytest
    - Citable DOI through Zenodo
    - Code coverage with Coveralls
- [PyHealth (A Python Library for Health Predictive Models)](https://github.com/zzachw/PyHealth)
    - Version control with GitHub
    - Continuous integration with Circle CI, Travis CI, AppVeyor
    - Capture and share project environment via pip
    - BSD-2-Clause license
    - Documentation with examples
    - Tests with pytest
    - Reproducible via Binder
- [VEROS (versatile ocean simulator Python / JAX)](https://github.com/team-ocean/veros)
    - Version control with GitHub
    - Continuous integration with GitHub Actions
    - Capture and share project environment via conda or pip
    - MIT license
    - Documentation with examples
    - Tests with pytest
    - Code coverage with codecov
