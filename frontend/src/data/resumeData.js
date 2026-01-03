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

    experience: [
      {
        id: 3,
        title: "ExamPro Training Inc - CEO and Co-founder",
        subtitle: "Free cloud learning study courses platform",
        location: "Schreiber, ON",
        duration: "2018-2025",
        details: [
          "Built a custom multi-tenant learning management system, deployed to AWS",
          "Created over 40 courses and 1000+ hours of educational content",
        ],
      }
    ],

    leadership: [
      {
      },
    ],

    skills_interests: [
      {
        id: 4,
        title: "ExamPro Cloud Essentials",
        subtitle: "Cloud Fundamentals and multi-cloud knowledge",
        location: "Online",
        duration: "Valid Till: 2025-2028",
      }
    ],
  },
  disclaimer: "This is an example résumé for instructional content and is not intended to be accurate.",
};

export default resumeData;