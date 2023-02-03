# Recommended Platforms

This guide asks a range of questions to consider when deciding which platform to use for your research. The suitable choice depends on your use cases and requirements.

## Considerations

### Are you using {ref}`personal data <personal_data>`?

- [LASER (Leeds Analytic Secure Environment for Research)](https://lida.leeds.ac.uk/about-lida/integrated-research-campus/)

### Does the work need a lot of memory?

- For example, a local laptop / workstation may have 4-64 GB
- There may be tools and methods to reduce memory usage, e.g., [SWD6: High Performance Python](https://arc.leeds.ac.uk/training/courses/swd6/)
- High Performance Computers (HPC)
  - [ARC3](../systems/arc3.html#standard-nodes)
    - Standard 128 GB
    - High-memory 768 GB
  - [ARC4](../systems/arc4.html#standard-nodes)
    - Standard 192 GB
    - High-memory 768 GB
- Cloud computing
  - [Microsoft Azure - Memory optimised](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-memory)

### Does the work need a lot of storage?

- For example, a local laptop / workstation may have 0.25-2 TB
- Network storage is [available from IT](https://it.leeds.ac.uk/it?id=kb_article&sysparm_article=KB0013189)
- Onedrive
  - 5 TB each, for all users
  - Quota increase is available on request to IT services
- HPC
  - [ARC3](../systems/arc3.html#lustre-storage)
    - 836 TB Lustre storage, at 4GB/s (/nobackup)
  - [ARC4](../systems/arc4.html#lustre-storage)
    - 1.2 PB Lustre storage, at 11GB/s (/nobackup)

### Do you need to parallelise the work over many cores?

- For example, a local laptop / workstation may have 4-16 cores
- HPC
  - [ARC3](../systems/arc3.html#standard-nodes)
    - 252 standard nodes, each with 24 cores
    - 4 high-memory nodes, each with 24 cores
  - [ARC4](../systems/arc4.html#standard-nodes)
    - 149 standard nodes, each with 40 cores
    - 2 high-memory nodes, each with 40 cores
- Cloud computing
  - [Microsoft Azure - Compute optimised](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-compute)

### Do you need to use GPUs?

- Buy a local laptop / workstation with a GPU
  - [Purchase form](https://it.leeds.ac.uk/it?id=sc_cat_item&sys_id=a649379c0f2f9b40a82247ece1050e25)
- HPC (multiple / more powerful GPUs)
  - [ARC3](../systems/arc3.html#gpgpu-nodes)
    - 2 x [general purpose GPU](https://en.wikipedia.org/wiki/General-purpose_computing_on_graphics_processing_units) nodes, each with 2 x [NVIDIA Tesla K80](https://www.nvidia.com/en-gb/data-center/tesla-k80/)
    - 6 x [general purpose GPU](https://en.wikipedia.org/wiki/General-purpose_computing_on_graphics_processing_units) nodes, each with 4 x [NVIDIA Tesla P100](https://www.nvidia.com/en-gb/data-center/tesla-p100/)
  - [ARC4](../systems/arc4.html#gpgpu-nodes)
    - 3 x [general purpose GPU](https://en.wikipedia.org/wiki/General-purpose_computing_on_graphics_processing_units) nodes, each with 4 x [NVIDIA Tesla V100](https://www.nvidia.com/en-gb/data-center/tesla-v100/)
  - [Bede](https://bede-documentation.readthedocs.io/en/latest/hardware/index.html)
    - 2 x login GPU nodes each with 4 x [NVIDIA Tesla V100](https://www.nvidia.com/en-gb/data-center/tesla-v100/)
    - 32 x GPU nodes each with 4 x [NVIDIA Tesla V100](https://www.nvidia.com/en-gb/data-center/tesla-v100/)
    - 4 x "inference" GPU nodes each with 4 x [NVIDIA Tesla T4](https://www.nvidia.com/en-gb/data-center/tesla-t4/)
  - [JADE-2](https://docs.jade.ac.uk/en/latest/)
    - 63 x [DGX-MAX-Q](https://www.nvidia.com/en-gb/data-center/dgx-systems/dgx-1/) Nodes, each with 8 x [NVIDIA Tesla V100](https://www.nvidia.com/en-gb/data-center/tesla-v100/)
- Cloud computing
  - [Microsoft Azure - GPU optimised](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-gpu)

## Cost

- *Azure*
  - When considering costs relating to research platforms it's important to think of cloud resources differently to on-campus hardware.
  - Cloud resources are typically not designed to be on all the time and all aspects of a cloud computational setup have costs associated i.e., you'll pay for your virtual machine (VM) whilst it's on, but you'll also need to pay for its storage, virtual network, and associated public IP address.
  - Therefore, when using cloud resources it's important to consider them as throwaway resources that you want to spin up to use, and after your experiments are complete, destroy the instance and its associated resources.
  - Below are some suggestions for how to initially scope costs on Azure, how to minimise your spending, and tips for monitoring spending on Azure.
  - *Scoping costs for Azure resources*
    - Pre-determine your cloud work schedule. Cloud costs are on a usage basis, so planning (even approximately) how many hours of compute you'll need will make scoping your costs easier.
    - Use the [Azure Price Calculator](https://azure.microsoft.com/en-gb/pricing/calculator/) to generate an approximate monthly budget for your cloud spend.
  - *Tips for minimising spending on Azure*
    - Always turn off your VMs when you're not using them.
    - When tidying up a VM setup, make sure you also delete other associated resources such as Managed Disks, public IP address, and virtual network.
  - *Tips for monitoring spending on Azure*
    - You can monitor your projected spend on Azure by checking the `Cost analysis` menu under `Cost Management` section on the left-hand menu when viewing a specific resource group. We encourage users to monitor this closely as especially initial costs can deviate until your setup stabilises.
    - You can configure specific cost alert emails be sent to you by using the `Cost alerts` menu under `Cost Management` section on the left-hand menu when viewing a specific resource group. This allows you to create a budget for a given period and once your resources uses a percentage of the specified budget you will receive an email alert.
- *LASER*
  - LASER runs using Azure for the provision of virtual machines but with some heavy technical controls in place to enable the analysis of high sensitive data in a research setting
  - Therefore LASER VMs or Virtual Research Environments (VREs) tend to be more permanent than a standard Azure VM which incurs more persistent costs. More details on this can be found on the [LASER website](https://lida-data-analytics-team.github.io/laserdocs/docs/laser_info/laser.html)
  - A cost estimate is available from the [DAT team](https://lida-data-analytics-team.github.io/laserdocs/docs/lida_services/dat.html) on request and a brief walkthrough of a basic LASER VM is detailed below. Below is an example of costs, other storage and compute specification are available and best discussed with the [DAT team](https://lida-data-analytics-team.github.io/laserdocs/docs/lida_services/dat.html)
  - *LASER Standard VM*
    - The basic assumption for usage of a LASER VM is 104 hours a month which takes into account full time usage during office hours (with adjustment for weekends, leave, and sickness).
    - The entry grade VM is a VMs D4s_v4 (4 vCPUs, 16 GB RAM) with 128GB of E10 Managed Disk storage.
    - 10GB of shared storage.
    - Azure private link services for shared storage.
    - Backups for both shared and VM storage.
    - Additional cost for time to build and destroy the VMs.
    - 2.5% FTE cost for support from the DAT team.

## Access

### How can I use LASER?

- Contact the Data Analytics Team at dat@leeds.ac.uk.

### How can I get an account on ARC3/4?

- [Request an account on ARC](../getting_started/request_hpc_acct)

### How can I get an account on Bede?

- Identify an existing project, or [register](https://n8cir.org.uk/supporting-research/facilities/bede/docs/bede_registrations/) a new one.
  - [Application](https://n8cir.org.uk/supporting-research/facilities/bede/bede-application/)
- Register on [EPCC SAFE account](https://safe.epcc.ed.ac.uk/) (to manage your account)
  - Once there, select "Project -> Request access" from the web interface and then register against your project

### How can I get an account on JADE-2?

- Register on Hartree Self Service (for technical support)
  - Click [here](https://stfc.service-now.com/hcssp) and use the register option in the top right-hand corner
- Register on Hartree SAFE (to manage your account)
  - Click [here](https://um.hartree.stfc.ac.uk/hartree/login.jsp) to register
  - Add your public SSH key following the instructions [here](https://stfc.service-now.com/kb?id=kb_article_view&sys_kb_id=318854b7db451410b40c9334ca9619ec)
- Request to join the project
  - From within SAFE, click "Request join project"
  - Select: J2AD014 - University of Leeds
  - An project administrator, can then provide the access code, accept you onto the project, and add you to the relevant group
- More detail is [here](https://www.jade.ac.uk/access/)
