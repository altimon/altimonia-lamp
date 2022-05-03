DevOps Engineer Take Home Assignment

This document lists the questions and exercises the DevOps Engineer candidates will be asked to respond / complete at home as part of the interviewing process. These are aligned with the
DevOps Engineer role description and designed to help the interviewing team confirm the high priority competencies required for this role.

The candidate has ~5 business days to complete the assignment and will be presenting the results to the team in a live discussion.

Prepare Application Infrastructure
Given a monolith web application, that we would like to host in AWS cloud (free tier), please prepare the following:
  ● A simple web application with the following requirements:
    ○ Can be written in your language of choice(i.e. python, nodejs, rails, go)
    ○ Has two health check endpoints
      ■ One endpoint to return 200 when called
      ■ One endpoint will connect to your database of choice, confirm successful connection
and return 200 when finished
  ● The application will connect to a RDS database of your choice(mysql, postgres, etc)
  ● The application will be hosted in an ECS cluster as a service (not standalone task)
    ○ Minimum hosts count:2
    ○ Minimum tasks count:2
  ● The application will be deployed as a docker image coming from a private repository(i.e.AWSECR)
  ● Entry point will be a loadbalancer of your choice(Classic,Application, or Network)
  ● You can decide the design on VPC(the more secure the better)


The infrastructure needs to be written as code in the frame work of your choice (Terraform, CloudFormation, CDK, etc)

  ● BonusPoint:
    ○ Prepare a way to connect to ECS instance or container for debug purposes
    ○ Or, prepare basic(or as many as you want) monitoring and alerting via CloudWatch
    ○ All of the above should be part of infrastructure code

    ● AdvancedBonusPoint:
      ○ Prepare the deploy pipeline using Github Actions, which will:
        ■ Run upon a tag push, you can decide on tag naming
        ■ Will build a docker image
        ■ Push it to ECR repository
        ■ Update ECS task definition with new image
        ■ Deploy new task definition to ECS service
        ■ Check health check endpoint to confirm successful deploy

It is perfectly acceptable if you do not finish the whole infrastructure as described above, please go as far as you could.

Please upload your project to GitHub and send us a link.
