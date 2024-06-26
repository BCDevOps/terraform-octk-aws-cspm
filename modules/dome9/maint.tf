resource "dome9_cloudaccount_aws" "this" {
  name = var.account_name

  credentials {
    arn    = aws_iam_role.dome9.arn
    secret = var.external_id
    type   = "RoleBased"
  }

  net_sec {
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_west_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_southeast_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_west_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "sa_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_southeast_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_central_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "us_east_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ca_central_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_2"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_west_3"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_north_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_east_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "me_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "af_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "eu_south_1"
    }
    regions {
      new_group_behavior = "ReadOnly"
      region             = "ap_northeast_3"
    }
  }

  depends_on = [time_sleep.wait_for_role]
}

resource "time_sleep" "wait_for_role" {
  create_duration = "10s"

  triggers = {
    role_arn = "${aws_iam_role.dome9.arn}"
  }

  depends_on = [aws_iam_role.dome9]

}

#Create the role and setup the trust policy
resource "aws_iam_role" "dome9" {
  name               = "PBMMAccel-BCGOV_CloudGuardConnect"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.dome9_aws_account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.external_id}"
        }
      }
    }
  ]
}
EOF
}

#Create the readonly policy
resource "aws_iam_policy" "readonly-policy" {
  name        = "PBMMAccel-BCGOV_CloudGuardReadOnly"
  description = ""
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CloudGuardReadOnly",
      "Effect": "Allow",
      "Action": [
        "fms:ListTagsForResource",
        "fms:GetAdminScope",
        "fms:GetPolicy",
        "fms:ListAdminAccountsForOrganization",
        "forecast:DescribeDataset",
        "forecast:DescribeAutoPredictor",
        "forecast:DescribePredictor",
        "forecast:ListDatasetGroups",
        "forecast:ListExplainabilities",
        "forecast:ListForecasts",
        "forecast:ListMonitors",
        "forecast:ListPredictors",
        "forecast:ListTagsForResource",
        "appfabric:ListAppBundles",
        "appfabric:GetAppBundle",
        "appfabric:ListTagsForResource",
        "lightsail:GetRelationalDatabases",
        "lightsail:GetRelationalDatabaseParameters",
        "lightsail:GetLoadBalancerTlsCertificates",
        "lightsail:GetDomains",
        "lightsail:GetDistributions",
        "batch:DescribeJobQueues",
        "kinesisanalytics:ListTagsForResource",
        "appflow:ListConnectors",
        "airflow:GetEnvironment",
        "apigateway:GET",
        "athena:GetQueryExecution",
        "backup:ListTags",
        "cassandra:Select",
        "codeartifact:ListDomains",
        "codeartifact:DescribeDomain",
        "codeartifact:ListTagsForResource",
        "codeartifact:DescribeRepository",
        "codebuild:GetResourcePolicy",
        "compute-optimizer:GetRecommendationSummaries",
        "macie2:DescribeBuckets",
        "macie2:GetMacieSession",
        "macie2:GetFindingStatistics",
        "verifiedpermissions:ListPolicyStores",
        "verifiedpermissions:GetPolicyStore",
        "elasticfilesystem:Describe*",
        "cloudhsm:DescribeClusters",
        "cloudhsm:DescribeBackups",
        "glacier:ListTagsForVault",
        "glue:GetConnections",
        "glue:GetMLTransforms",
        "healthlake:ListTagsForResource",
        "kendra:ListTagsForResource",
        "devops-guru:DescribeServiceIntegration",
        "kinesis:List*",
        "kinesis:Describe*",
        "kinesisvideo:Describe*",
        "kinesisvideo:List*",
        "logs:Get*",
        "logs:FilterLogEvents",
        "logs:ListLogDeliveries",
        "codebuild:ListBuilds",
        "codebuild:BatchGetBuilds",
        "codepipeline:ListWebhooks",
        "memorydb:DescribeACLs",
        "memorydb:DescribeParameters",
        "memorydb:DescribeSnapshots",
        "memorydb:DescribeUsers",
        "memorydb:ListTags",
        "personalize:ListTagsForResource",
        "s3:List*",
        "ses:ListEmailIdentities",
        "ses:GetEmailIdentity",
        "ses:GetConfigurationSet",
        "sns:ListPlatformApplications",
        "transcribe:Get*",
        "transcribe:List*",
        "translate:GetTerminology",
        "appstream:DescribeUsageReportSubscriptions",
        "aps:ListWorkspaces",
        "aps:DescribeWorkspace",
        "aps:DescribeLoggingConfiguration",
        "cloudformation:ListTypes",
        "cloudformation:DescribeType",
        "cloudformation:BatchDescribeTypeConfigurations",
        "amplify:ListApps",
        "serverlessrepo:GetApplication",
        "simspaceweaver:ListSimulations",
        "simspaceweaver:ListTagsForResource",
        "simspaceweaver:DescribeSimulation",
        "grafana:DescribeWorkspace",
        "mediaconvert:ListJobs",
        "mediaconvert:ListPresets",
        "mediaconvert:ListQueues",
        "mediaconvert:ListTagsForResource",
        "mediapackage:ListChannels",
        "mediastore:ListTagsForResource",
        "mediatailor:ListChannels",
        "mediatailor:GetChannelPolicy",
        "mediatailor:ListPlaybackConfigurations",
        "mediatailor:ListSourceLocations",
        "mediapackage:ListHarvestJobs",
        "dataexchange:ListTagsForResource",
        "dataexchange:ListEventActions",
        "dataexchange:ListJobs",
        "elastictranscoder:ListPresets",
        "medialive:ListInputs",
        "medialive:ListMultiplexes",
        "medialive:ListReservations",
        "medialive:ListInputSecurityGroups",
        "drs:DescribeJobs",
        "drs:DescribeJobLogItems",
        "drs:DescribeSourceServers",
        "drs:DescribeRecoverySnapshots",
        "drs:DescribeSourceNetworks",
        "drs:DescribeRecoveryInstances",
        "drs:GetFailbackReplicationConfiguration",
        "drs:DescribeReplicationConfigurationTemplates",
        "drs:DescribeLaunchConfigurationTemplates",
        "timestream:ListBatchLoadTasks",
        "timestream:ListDatabases",
        "timestream:ListTables",
        "timestream:ListTagsForResource",
        "timestream:DescribeEndpoints",
        "timestream:ListScheduledQueries",
        "signer:ListTagsForResource",
        "signer:ListSigningJobs",
        "signer:ListSigningPlatforms",
        "signer:ListSigningProfiles",
        "storagegateway:DescribeSMBFileShares",
        "ds:ListTagsForResource",
        "support:DescribeCases",
        "support:DescribeSeverityLevels",
        "outposts:ListOutposts",
        "waf-regional:ListLoggingConfigurations",
        "wafv2:GetIPSet",
        "finspace:ListTagsForResource",
        "lakeformation:GetDataLakeSettings",
        "sagemaker:DescribeTrainingJob",
        "sagemaker:DescribeNotebookInstance",
        "sagemaker:ListTrainingJobs",
        "sagemaker:ListNotebookInstances",
        "cognito-idp:ListResourcesForWebACL",
        "apprunner:ListAssociatedServicesForWebAcl",
        "account:GetContactInformation"
      ],
      "Resource": "*"
    },
    {
      "Sid": "CloudGuardDeny",
      "Effect": "Deny",
      "Action": [
        "glacier:GetJobOutput",
        "s3:GetObjectTorrent",
        "dynamodb:BatchGet*",
        "dynamodb:PartiQLSelect",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:Get*",
        "qldb:GetBlock",
        "qldb:GetDigest",
        "qldb:GetRevision",
        "sdb:Select*"
      ],
      "Resource": "*"
    }
  ]
}

EOF
}

#Attach policies to the cross-account role
resource "aws_iam_policy_attachment" "attach-d9-read-policy" {
  name       = "attach-readonly"
  roles      = [aws_iam_role.dome9.name]
  policy_arn = aws_iam_policy.readonly-policy.arn
}

resource "aws_iam_role_policy_attachment" "attach-security-audit" {
  role       = aws_iam_role.dome9.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
