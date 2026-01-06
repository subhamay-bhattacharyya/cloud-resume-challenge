import React from "react";
import 'css/pages/resume.css'

import resumeData from 'data/resumeData'
import ResumeHeader from 'comps/resume/ResumeHeader'
import ResumeSection from 'comps/resume/ResumeSection'

export default function ResumePage() {
  

  return (
    <>
      <ResumeHeader person={resumeData.person}></ResumeHeader>
      <ResumeSection title='Education' handle='education' section={resumeData.sections.education} />
      <ResumeSection title='Skills' handle='skills' section={resumeData.sections.skills} />
      <ResumeSection title='Capgemini' handle='experience' section={resumeData.sections.capgemini} />
      <ResumeSection title='Compugain' handle='experience' section={resumeData.sections.compugain} />
      <ResumeSection title='3i Infotech' handle='experience' section={resumeData.sections.infotech} />
      <ResumeSection title='Genpact' handle='experience' section={resumeData.sections.genpact} />
      <div className="disclaimer">
        This résumé has been developed as a part of my cloud resume challenge project and hosted in the AWS Cloud github repository - <a href="https://github.com/subhamay-bhattacharyya/cloud-resume-challenge">https://github.com/subhamay-bhattacharyya/cloud-resume-challenge</a>
      </div>
    </>
  );
}