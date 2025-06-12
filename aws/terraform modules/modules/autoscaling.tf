module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "${var.project_name}-autoscaling-group"

  min_size                  = 0
  max_size                  = 3
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]


  # Launch template
  launch_template_name        = "${var.project_name}-launch-template"
  launch_template_description = "Launch template for the project '${var.project_name}'"
  update_default_version      = true

  image_id      = data.aws_ami.this.id
  instance_type = var.instance_type

  security_groups = [module.web_server_sg.security_group_id]
  user_data       = filebase64("scripts/userdata.sh")

  # CORRECT WAY TO ATTACH TO ALB TARGET GROUP USING THE MODULE'S LATEST SYNTAX
  traffic_source_attachments = {
    main_alb_attachment = { # This is an arbitrary key for the attachment block
      traffic_source_identifier = module.alb.target_groups.web_server_target_group.arn # Reference the ALB target group ARN
      traffic_source_type       = "elbv2" # This is the default for ALBs, but explicit is good
    }
  }
}



module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
}