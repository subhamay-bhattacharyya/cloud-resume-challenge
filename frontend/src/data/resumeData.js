const resumeData = {
  person: {
    name: "Subhamay Bhattacharyya",
    contact: {
      address: "23 Rosebud Dr, Trumbull, CT-06611, USA",
      email: "subhamay@subhamay.cloud",
      phone: "+1 203-482-3898",
    },
  },

  sections: {
    education: [
      {
        id: 1,
        title: "National Institute of Technology",
        subtitle: "Master of Computer Applications (MCA)",
        location: "Rourkela, Odisha, India",
        duration: "1997-2000",
      },
      {
        id: 2,
        title: "St. Xavier's College, Calcutta University",
        subtitle: "Bachelor of Science (B.Sc.), Mathematics",
        location: "Kolkata, India",
        duration: "1994-1997",
      },
    ],

    capgemini: [
      {
        id: 3,
        title: "Adobe Experience Platform (AEP) API Development - Vanguard",
        subtitle: "API Development using API Gateway, Lambda, Glue, S3, SNS, SQS, Route 53, ALB",
        location: "Malvern, PA",
        duration: "Oct'24 - Dec'25",
        details: [
          "Acted as Architect and Lead Developer, owning the end-to-end solution and working directly with the client’s engineering counterpart",
          "Designed scalable ingestion mechanisms to process AEP data and transform it for internal consumption",
          "Architected and implemented RESTful APIs using AWS API Gateway and Application Load Balancer with secure routing via Route 53",
          "Built durable, asynchronous processing pipelines using SNS and SQS, integrating AWS Glue for downstream transformations",
          "Established observability dashboards and distributed tracing with Honeycomb to ensure performance and reliability",
          "Managed stakeholder expectations, defined architectural patterns, and ensured successful delivery of a business-critical platform"
        ],
      },
      {
        id: 4,
        title: "DataStage Modernization - Vanguard",
        subtitle: "Glue job orchestration using Step Function, Lambda, DynamoDB",
        location: "Malvern, PA",
        duration: "May'24 - Sep'24",
        details: [
          "Converted legacy DataStage transformations into AWS Glue PySpark jobs with optimal partitioning and data handling strategies",
          "Developed orchestration workflows using AWS Lambda and Step Functions, enabling dynamic, metadata-driven ETL execution",
          "Designed and populated DynamoDB metadata schemas to centralize job configuration and runtime parameters",
          "Implemented automated monitoring, logging, and alerting for ETL jobs to improve reliability and operational visibility",
          "Supported knowledge transfer and collaborated closely with cross-functional teams to ensure smooth adoption and operational continuity"
        ],
      },
      {
        id: 5,
        title: "Cloud Business Office – AWS Cost Reduction Initiative - Vanguard",
        subtitle: "AWS Cost Optimization and FinOps Automation.",
        location: "Malvern, PA",
        duration: "Mar'24 - Apr'24",
        details: [
          "Developed automation scripts and workflows to identify, track, and remediate high-cost AWS resources",
          "Built serverless solutions for scheduled insights, notifications, and data processing pipelines",
          "Collaborated with FinOps stakeholders to refine cloud usage analytics and provide actionable recommendations"
        ],
      },
      {
        id: 6,
        title: "Retail PAS Cloud Modernization - Vanguard",
        subtitle: "Application and Data Migration from legacy Mainframe to AWS Cloud.",
        location: "Malvern, PA",
        duration: "Mar'22 - Mar'24",
        details: [
          "Developed automation scripts and workflows to identify, track, and remediate high-cost AWS resources",
          "Built serverless solutions for scheduled insights, notifications, and data processing pipelines",
          "Collaborated with FinOps stakeholders to refine cloud usage analytics and provide actionable recommendations"
        ],
      },
    ],

    compugain: [
      {
        id: 7,
        title: "Cloud Data Migration, Freddie Mac",
        subtitle: "Legacy Data Migration to AWS using Talend Big Data",
        location: "McLean, VA",
        duration: "Apr'21 - Feb'22",
        details: [
          "Executed large-scale data integration solutions leveraging Talend Big Data to support enterprise analytics initiatives",
          "Translated complex business logic into modular, reusable Talend transformations and data mappings",
          "Engineered Talend ETL pipelines adhering to industry-standard design patterns and data engineering best practices",
          "Developed both conventional Talend jobs and Spark-based processing workflows for big data environments",
          "Configured context variables and parameterized job frameworks to enable scalable and reusable ETL deployments",
          "Extended Talend functionality by implementing custom Java-based routines",
          "Authored comprehensive technical documentation including design specifications, test cases, and deployment guides",
          "Implemented reliable data ingestion pipelines into Amazon Redshift using Talend",
          "Developed advanced SQL queries to support data validation, transformation, and reporting needs",
          "Worked across AWS services such as EMR, RDS, Lambda, S3, SQS, and SNS to build distributed data solutions",
          "Actively contributed within an Agile delivery model, collaborating across teams and participating in daily Scrum ceremonies"],
      },
    ],

    infotech: [
      {
        id: 8,
        title: "AWS Data Lake and Report Generation - Fannie Mae",
        subtitle: "AWS Data Lake using Redshift, S3, Lambda, EMR, Dremio",
        location: "Reston, VA",
        duration: "Mar'20 - Mar'21",
        details: [
          "Acted as Architect and Lead Developer, owning the end-to-end solution and working directly with the client’s engineering counterpart",
          "Designed scalable ingestion mechanisms to process AEP data and transform it for internal consumption",
          "Architected and implemented RESTful APIs using AWS API Gateway and Application Load Balancer with secure routing via Route 53",
          "Built durable, asynchronous processing pipelines using SNS and SQS, integrating AWS Glue for downstream transformations",
          "Established observability dashboards and distributed tracing with Honeycomb to ensure performance and reliability",
          "Managed stakeholder expectations, defined architectural patterns, and ensured successful delivery of a business-critical platform"
        ],
      },
    ],

    genpact: [
      {
        id: 9,
        title: "Data Visualization with Python, Pandas, Matplotlib - Pfizer",
        subtitle: "Assisted in data analysis and visualization using Python libraries",
        location: "NY City, NY",
        duration: "Nov'19 - Mar'20",
        details: [
          "Developed data visualization dashboards for scoring models using Python Dash, Plotly, and Matplotlib",
          "Parsed emails and attachments stored as JSON in Oracle databases to extract case numbers using regular expressions",
          "Performed data wrangling, cleansing, merging, and feature engineering using Pandas on AWS EC2 and RDS environments",
          "Created analytical charts and exploratory visualizations in Jupyter Notebook using Matplotlib for preliminary data analysis",
          "Utilized Python libraries including NumPy, Pandas, Plotly, Dash, CSV, JSON, and Scikit-Learn for data processing and modeling"],
      },
      {
        id: 10,
        title: "Data Engineer - GE Power",
        subtitle: "Python Pandas, Talend, Greenplum, AWS RDS",
        location: "Atlanta, GA",
        duration: "Sep'19 - Nov'19",
        details: [
          "Designed and developed ETL jobs in Talend using GE’s internal EDL framework"]
      },
      {
        id: 11,
        title: "Data Engineer - Wells Fargo",
        subtitle: "Microsoft SQL Developer, T-SQL Developer, SSIS Developer ",
        location: "Charlotte, NC",
        duration: "Mar'19 - Sep'19",
        details: [
          "Designed a unified analytics platform for large-scale investment data",
          "Developed Talend Big Data jobs ingesting XML, JSON, and flat files",
          "Created T-SQL stored procedures for real-time data processing",
          "Modeled star, snowflake, and galaxy schemas using SAP PowerDesigner",
          "Guided Tableau developers and optimized reporting models",
          "Evaluated Snowflake during POC (later standardized on SQL Server)"
        ]
      },
      {
        id: 12,
        title: "Oracle E-Business Suite Team Lead / Developer - GE Corporate, GE Digital, Knapp & Vogt, Diebold Nixdorf, GE Oil & Gas, GE Plastics / SABIC Innovative Plastics",
        subtitle: "Oracle EBS, PL/SQL Developer ",
        location: "Hyderabad, India / North Canton, OH / Houston, TX / Charlotte, NC / Cincinnati, OH / Stamford, CT",
        duration: "Feb'06 - Feb'19",
        details: [
          "Worked as a conversion lead at GE Corporate (Stamford, CT), liaising between onsite business teams and offshore technical teams",
          "Guided offshore teams on data conversion methods, resolving mapping issues in Oracle Endeca and Oracle E-Business Suite",
          "Developed Python preprocessing scripts to handle large mainframe data files, filtering required columns and removing redundant data",
          "Converted mainframe data encoding from EBCDIC to UTF-8 and cleansed non-printable characters and invalid column values",
          "Led end-to-end data conversion activities, including requirement gathering, development, testing, and deployment",
          "Served as Technical Lead at GE Digital (Cincinnati, OH), managing a distributed team of 10 across the US, India, and Philippines",
          "Designed and developed interfaces integrating Oracle with third-party applications",
          "Led delivery of multiple technical components across cross-functional Oracle E-Business Suite R12 modules",
          "Ensured code quality through reviews, adherence to client standards, and mentoring team members on complex issues",
          "Managed code migration, release activities, Oracle SR responses, and production issue resolution",
          "Performed unit testing, environment migrations, user testing support, and ticket closure",
          "Collaborated closely with functional teams to understand business requirements and drive conversion solutions",
          "Developed critical CEMLI components at Knapp & Vogt (Hyderabad, India), including label printing for the WMS module",
          "Participated in design reviews, code reviews, development, and testing activities",
          "Worked as a developer and onsite-offshore coordinator at GE Oil & Gas (Houston, TX)",
          "Customized Oracle CRM suite components as a technical developer at Diebold Nixdorf (North Canton, OH)",
          "Worked on Oracle ERP implementation, support, and enhancements at GE Plastics / SABIC Innovative Plastics (Hyderabad, India)",
          "Developed ETL solutions using SAP BODS, Oracle PL/SQL, and Unix Shell Scripting",
          "Followed Oracle AIM methodology across projects, including MD50 and MD70 documentation standards"
        ]
      }
    ],


    skills: [
      {
        id: 13,
        title: "Amazon Web Services (AWS)",
        subtitle: "Lambda, S3, Glue, Athena, DynamoDB, RDS, Redshift, Step Functions, CloudWatch, IAM, API Gateway, EventBridge",
      },
      {
        id: 14,
        title: "Google Cloud Platform (GCP)",
        subtitle: "BigQuery, Cloud Storage, Cloud Functions, Pub/Sub, Dataflow, Composer (Airflow), IAM"
      },
      {
        id: 15,
        title: "Terraform & IaC",
        subtitle: "Terraform, HCP Terraform, CloudFormation, Modular IaC, Remote State, OIDC, CI/CD Automation"
      },
      {
        id: 16,
        title: "Microsoft Azure",
        subtitle: "Azure Data Factory, Azure Functions, Azure Storage, Azure SQL, Synapse Analytics"
      },
      {
        id: 17,
        title: "Snowflake",
        subtitle: "Snowflake SQL, Warehousing, Data Modeling, POC Evaluation, Performance Optimization"
      },
      {
        id: 18,
        title: "GitHub & DevOps",
        subtitle: "GitHub Actions, Reusable Workflows, Composite Actions, OIDC, CI/CD Pipelines, GitHub CLI"
      },
      {
        id: 18,
        title: "Astronomer & Airflow",
        subtitle: "Apache Airflow, DAG Design, Astronomer Platform, Scheduling, Monitoring, Data Pipelines"
      }
    ],
  }
};

export default resumeData;