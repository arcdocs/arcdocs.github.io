# Advanced Research Computing Documentation

This is the repository for the documentation for the University of Leeds HPC systems (ARC3 and ARC4). This is managed by the University of Leeds [Research Computing Team](https://arc.leeds.ac.uk).

This repository automatically builds and deploys html content onto the repository github pages domain https://arc.leeds.ac.uk

## Repository branch organisation

Because this is a user/Organisation page on GitHub the website is hosted from the master branch so the working code base for the website (containing the contents but not the html!) is on the branch `working-master`. All html content is automatically built by our GitHub action and committed the master branch.

## Working with this project locally

You can get this project working locally by using the environment.yml file to create a conda environment that contains all the dependencies required to get started.

```{bash}
$ git clone https://github.com/arcdocs/arcdocs.github.io.git

$ git checkout working-master # all work should be on this branch

$ conda env create -f environment.yml
```

To build the html content locally you can use the `jupyter-book` command line tool:

```{bash}
# navigate to the repository root
$ cd arcdocs-jupyterbook
# sometimes worth running jupyter-book clean book/ to remove old files
$ jupyter-book build book/
```

### pre-commit

If you want to enable pre-commit so that it's automatically invoked when you do a commit:
```{bash}
pre-commit install
```

Now pre-commit will correct obvious mistakes with your commits, and flag up unfixable ones.

### Windows

An important note is that there are currently known issues running JupyterBook on Windows ([see here for more (including workarounds)](https://jupyterbook.org/advanced/advanced.html#working-on-windows)).

To aid with this we have created a `Vagrantfile` that can allow Windows users who have a virtualisation provider installed (such as [VirtualBox](https://www.virtualbox.org/)) and [Vagrant](https://www.vagrantup.com/) installed to create a headless virtual Linux machine that will build the jupyter book. You can do this with the following steps once you've installed a virtualisation provider and vagrant:
```
# within git-bash or powershell
$ cd arcdocs.github.io
$ vagrant up

# to rebuild the site after changes with the vagrant box running
$ vagrant reload --provision

# don't forget to destroy the box when you're done
$ vagrant destroy
```

This will build the jupyter-book html files on your Windows file system (by navigating via /vagrant) so your local build will still persist after you've destroyed your vagrant box.
