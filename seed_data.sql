-- Demo data for Resume Analyzer Pro (safe to run on top of the 12 seed jobs)
-- Login for every demo user: password  Demo@123
USE resume_analyzer;

-- 1) USERS
INSERT INTO user (first_name,last_name,email,phone,password,created_at) VALUES
('Rohan','Patil','rohan.patil@demo.com','9876501001','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 12 DAY)),
('Sneha','Kulkarni','sneha.kulkarni@demo.com','9876501002','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 10 DAY)),
('Amit','Deshmukh','amit.deshmukh@demo.com','9876501003','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 9 DAY)),
('Priya','Joshi','priya.joshi@demo.com','9876501004','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 7 DAY)),
('Vikram','More','vikram.more@demo.com','9876501005','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 5 DAY)),
('Neha','Sharma','neha.sharma@demo.com','9876501006','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 3 DAY)),
('Aditya','Pawar','aditya.pawar@demo.com','9876501007','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 2 DAY)),
('Kavita','Jadhav','kavita.jadhav@demo.com','9876501008','scrypt:32768:8:1$JvCC7trNBxfLxgIq$a1de713c3617b2397305c3598a6efe1be12ca574b005c83195e47ea91241e091b9fff6328e3514f288907adad65b9a188586a814b472fb112e17b173d15a7ac7',DATE_SUB(NOW(),INTERVAL 1 DAY));

-- 2) RESUMES
INSERT INTO resume (uid,file,upload_date) VALUES
((SELECT uid FROM user WHERE email='rohan.patil@demo.com'),'101_1790000101_Rohan_Patil_Resume.pdf',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT uid FROM user WHERE email='sneha.kulkarni@demo.com'),'102_1790000102_Sneha_Kulkarni_Resume.pdf',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT uid FROM user WHERE email='amit.deshmukh@demo.com'),'103_1790000103_Amit_Deshmukh_Resume.pdf',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT uid FROM user WHERE email='priya.joshi@demo.com'),'104_1790000104_Priya_Joshi_Resume.pdf',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT uid FROM user WHERE email='vikram.more@demo.com'),'105_1790000105_Vikram_More_Resume.pdf',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT uid FROM user WHERE email='neha.sharma@demo.com'),'106_1790000106_Neha_Sharma_Resume.pdf',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT uid FROM user WHERE email='aditya.pawar@demo.com'),'107_1790000107_Aditya_Pawar_Resume.pdf',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT uid FROM user WHERE email='kavita.jadhav@demo.com'),'108_1790000108_Kavita_Jadhav_Resume.pdf',DATE_SUB(NOW(),INTERVAL 1 DAY));

-- 3) SKILLS
INSERT INTO skill (rid,skill) VALUES
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'python'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'flask'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'mysql'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'sql'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'html'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'css'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'javascript'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'git'),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),'rest api'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'python'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'pandas'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'numpy'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'matplotlib'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'sql'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'excel'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'power bi'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'machine learning'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'scikit-learn'),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),'data science'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'java'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'spring boot'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'mysql'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'sql'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'git'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'rest api'),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),'docker'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'html'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'css'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'javascript'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'react'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'bootstrap'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'nodejs'),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),'git'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'python'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'machine learning'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'deep learning'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'tensorflow'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'keras'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'pandas'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'numpy'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'opencv'),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),'nlp'),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),'python'),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),'sql'),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),'excel'),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),'tableau'),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),'power bi'),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),'pandas'),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),'docker'),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),'kubernetes'),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),'aws'),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),'linux'),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),'git'),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),'python'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'python'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'django'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'flask'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'postgresql'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'sql'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'html'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'css'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'javascript'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'git'),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),'rest api');

-- 4) MATCH RESULTS (scores computed with the app's own TF-IDF + cosine formula)
INSERT INTO matchresult (rid,jid,score,status,created_at) VALUES
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),44.94,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),34.9,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),14.14,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),34.9,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),70.93,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),7.4,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),17.86,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),29.53,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),34.9,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),34.9,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),17.86,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='101_1790000101_Rohan_Patil_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),8.18,'Analyzed',DATE_SUB(NOW(),INTERVAL 11 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),23.77,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),19.43,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),13.38,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),7.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),35.63,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),57.97,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),16.84,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),19.43,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),57.97,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='102_1790000102_Sneha_Kulkarni_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 9 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),12.54,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),10.6,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),41.04,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),8.46,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),9.35,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),51.94,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),40.74,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),9.35,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='103_1790000103_Amit_Deshmukh_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),20.61,'Analyzed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),63.48,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),30.41,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),63.48,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),10.6,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='104_1790000104_Priya_Joshi_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),9.35,'Analyzed',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),10.96,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),9.27,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),7.4,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),70.93,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),17.86,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),8.18,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),9.27,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),17.86,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='105_1790000105_Vikram_More_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 4 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),31.88,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),26.06,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),17.58,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),9.19,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),20.2,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),84.66,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),22.58,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),26.06,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),22.58,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='106_1790000106_Neha_Sharma_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),13.63,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),11.52,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),9.19,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),9.19,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),10.16,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),22.58,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),0.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),26.06,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),10.16,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='107_1790000107_Aditya_Pawar_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),84.66,'Analyzed',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='ABC Tech' LIMIT 1),42.22,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Python Developer' AND company_name='Infosys' LIMIT 1),50.23,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Java Developer' AND company_name='TCS' LIMIT 1),13.38,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Frontend Developer' AND company_name='Wipro' LIMIT 1),32.79,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Full Stack Developer' AND company_name='Accenture' LIMIT 1),49.08,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Machine Learning Engineer' AND company_name='Google' LIMIT 1),7.0,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Analyst' AND company_name='Deloitte' LIMIT 1),16.84,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Backend Developer' AND company_name='Amazon' LIMIT 1),27.74,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Web Developer' AND company_name='Capgemini' LIMIT 1),32.79,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Software Engineer' AND company_name='IBM' LIMIT 1),32.79,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='Data Scientist' AND company_name='Fractal' LIMIT 1),16.84,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT rid FROM resume WHERE file='108_1790000108_Kavita_Jadhav_Resume.pdf'),(SELECT jid FROM jobdesc WHERE title='DevOps Engineer' AND company_name='HCL Technologies' LIMIT 1),7.73,'Analyzed',DATE_SUB(NOW(),INTERVAL 1 DAY));

-- 5) FEEDBACK
INSERT INTO feedback (uid,mid,rating,category,comment,placed_status,continue_status,submitted_at) VALUES
((SELECT uid FROM user WHERE email='rohan.patil@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='101_1790000101_Rohan_Patil_Resume.pdf' AND j.title='Python Developer' AND j.company_name='ABC Tech' LIMIT 1),5,'Job Matching Quality','Very accurate matches, Python Developer jobs came on top.','Searching','Continuing',DATE_SUB(NOW(),INTERVAL 10 DAY)),
((SELECT uid FROM user WHERE email='sneha.kulkarni@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='102_1790000102_Sneha_Kulkarni_Resume.pdf' AND j.title='Data Analyst' AND j.company_name='Deloitte' LIMIT 1),5,'Skill Detection','It detected all my data analysis skills correctly.','Placed','Continuing',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT uid FROM user WHERE email='amit.deshmukh@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='103_1790000103_Amit_Deshmukh_Resume.pdf' AND j.title='Java Developer' AND j.company_name='TCS' LIMIT 1),4,'User Interface','Clean and easy to use. Would like more Java jobs.','Searching','Continuing',DATE_SUB(NOW(),INTERVAL 7 DAY)),
((SELECT uid FROM user WHERE email='priya.joshi@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='104_1790000104_Priya_Joshi_Resume.pdf' AND j.title='Frontend Developer' AND j.company_name='Wipro' LIMIT 1),4,'Job Matching Quality','Frontend match was good and the missing-skills list helped me.','Searching','Continuing',DATE_SUB(NOW(),INTERVAL 5 DAY)),
((SELECT uid FROM user WHERE email='vikram.more@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='105_1790000105_Vikram_More_Resume.pdf' AND j.title='Machine Learning Engineer' AND j.company_name='Google' LIMIT 1),5,'Skill Detection','Detected ML and deep learning skills perfectly.','Placed','Left',DATE_SUB(NOW(),INTERVAL 3 DAY)),
((SELECT uid FROM user WHERE email='neha.sharma@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='106_1790000106_Neha_Sharma_Resume.pdf' AND j.title='Data Analyst' AND j.company_name='Deloitte' LIMIT 1),3,'Speed & Performance','Useful, but analysis took a little time to load.','Searching','Continuing',DATE_SUB(NOW(),INTERVAL 2 DAY)),
((SELECT uid FROM user WHERE email='aditya.pawar@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='107_1790000107_Aditya_Pawar_Resume.pdf' AND j.title='DevOps Engineer' AND j.company_name='HCL Technologies' LIMIT 1),4,'Other','Good idea. Please add more DevOps job roles.','Searching','Continuing',DATE_SUB(NOW(),INTERVAL 1 DAY)),
((SELECT uid FROM user WHERE email='kavita.jadhav@demo.com'),(SELECT m.mid FROM matchresult m JOIN resume rs ON rs.rid=m.rid JOIN jobdesc j ON j.jid=m.jid WHERE rs.file='108_1790000108_Kavita_Jadhav_Resume.pdf' AND j.title='Python Developer' AND j.company_name='Infosys' LIMIT 1),5,'Job Matching Quality','Matched my Django and SQL skills with the right jobs.','Searching','Continuing',DATE_SUB(NOW(),INTERVAL 0 DAY));

-- 6) QUICK CHECK
SELECT (SELECT COUNT(*) FROM user) users,(SELECT COUNT(*) FROM resume) resumes,(SELECT COUNT(*) FROM skill) skills,(SELECT COUNT(*) FROM jobdesc) jobs,(SELECT COUNT(*) FROM matchresult) matches,(SELECT COUNT(*) FROM feedback) feedback;

SET @pw = 'scrypt:32768:8:1$L1Rx2fZfhwKwzT2k$0e1b6c258c91c10a42127cd401238c436e6c6e36a4e05672b21c4098e3bbf178b1dd8f2d99c04c7ad0a689b4948a2ee44c4ad0ab036f5b3efa719a45cdc45ad6';
SET @off = (SELECT MIN(jid) FROM jobdesc) - 1;

INSERT INTO jobdesc (title,company_name,req) VALUES
('Android Developer','Paytm','java,kotlin,android,rest api,git'),
('Flutter Developer','Zomato','flutter,rest api,git,android'),
('PHP Developer','Tech Mahindra','php,mysql,html,css,javascript'),
('QA Automation Engineer','Cognizant','selenium,python,java,jira,sql'),
('Cloud Engineer','Microsoft','azure,docker,kubernetes,linux,python'),
('MERN Stack Developer','Persistent Systems','mongodb,express,react,nodejs,javascript,html,css'),
('Angular Developer','LTIMindtree','angular,typescript,html,css,javascript'),
('Data Engineer','Mphasis','python,sql,aws,pandas,postgresql'),
('Business Intelligence Analyst','Mu Sigma','sql,tableau,power bi,excel'),
('Computer Vision Engineer','Nvidia','python,opencv,deep learning,pytorch,numpy'),
('NLP Engineer','Zensar','python,nlp,machine learning,pytorch,scikit-learn'),
('FastAPI Backend Developer','Razorpay','python,fastapi,postgresql,docker,rest api');

INSERT INTO user (first_name,last_name,email,phone,password,created_at) VALUES
('Siddharth','Kale','siddharth.kale@demo.com','9876502001',@pw,DATE_SUB(NOW(),INTERVAL 28 DAY)),
('Pooja','Bhosale','pooja.bhosale@demo.com','9876502002',@pw,DATE_SUB(NOW(),INTERVAL 26 DAY)),
('Rahul','Gaikwad','rahul.gaikwad@demo.com','9876502003',@pw,DATE_SUB(NOW(),INTERVAL 24 DAY)),
('Anjali','Nair','anjali.nair@demo.com','9876502004',@pw,DATE_SUB(NOW(),INTERVAL 21 DAY)),
('Harsh','Mehta','harsh.mehta@demo.com','9876502005',@pw,DATE_SUB(NOW(),INTERVAL 19 DAY)),
('Shruti','Bhatt','shruti.bhatt@demo.com','9876502006',@pw,DATE_SUB(NOW(),INTERVAL 17 DAY)),
('Tejas','Wagh','tejas.wagh@demo.com','9876502007',@pw,DATE_SUB(NOW(),INTERVAL 15 DAY)),
('Meera','Iyer','meera.iyer@demo.com','9876502008',@pw,DATE_SUB(NOW(),INTERVAL 13 DAY)),
('Omkar','Salunkhe','omkar.salunkhe@demo.com','9876502009',@pw,DATE_SUB(NOW(),INTERVAL 11 DAY)),
('Divya','Reddy','divya.reddy@demo.com','9876502010',@pw,DATE_SUB(NOW(),INTERVAL 9 DAY)),
('Karan','Singh','karan.singh@demo.com','9876502011',@pw,DATE_SUB(NOW(),INTERVAL 7 DAY)),
('Isha','Thakur','isha.thakur@demo.com','9876502012',@pw,DATE_SUB(NOW(),INTERVAL 4 DAY));

INSERT INTO resume (uid,file,upload_date) VALUES
((SELECT uid FROM user WHERE email='siddharth.kale@demo.com'),'2001_1790002001_Siddharth_Kale_Resume.pdf',DATE_SUB(NOW(),INTERVAL 27 DAY)),
((SELECT uid FROM user WHERE email='pooja.bhosale@demo.com'),'2002_1790002002_Pooja_Bhosale_Resume.pdf',DATE_SUB(NOW(),INTERVAL 25 DAY)),
((SELECT uid FROM user WHERE email='rahul.gaikwad@demo.com'),'2003_1790002003_Rahul_Gaikwad_Resume.pdf',DATE_SUB(NOW(),INTERVAL 23 DAY)),
((SELECT uid FROM user WHERE email='anjali.nair@demo.com'),'2004_1790002004_Anjali_Nair_Resume.pdf',DATE_SUB(NOW(),INTERVAL 20 DAY)),
((SELECT uid FROM user WHERE email='harsh.mehta@demo.com'),'2005_1790002005_Harsh_Mehta_Resume.pdf',DATE_SUB(NOW(),INTERVAL 18 DAY)),
((SELECT uid FROM user WHERE email='shruti.bhatt@demo.com'),'2006_1790002006_Shruti_Bhatt_Resume.pdf',DATE_SUB(NOW(),INTERVAL 16 DAY)),
((SELECT uid FROM user WHERE email='tejas.wagh@demo.com'),'2007_1790002007_Tejas_Wagh_Resume.pdf',DATE_SUB(NOW(),INTERVAL 14 DAY)),
((SELECT uid FROM user WHERE email='meera.iyer@demo.com'),'2008_1790002008_Meera_Iyer_Resume.pdf',DATE_SUB(NOW(),INTERVAL 12 DAY)),
((SELECT uid FROM user WHERE email='omkar.salunkhe@demo.com'),'2009_1790002009_Omkar_Salunkhe_Resume.pdf',DATE_SUB(NOW(),INTERVAL 10 DAY)),
((SELECT uid FROM user WHERE email='divya.reddy@demo.com'),'2010_1790002010_Divya_Reddy_Resume.pdf',DATE_SUB(NOW(),INTERVAL 8 DAY)),
((SELECT uid FROM user WHERE email='karan.singh@demo.com'),'2011_1790002011_Karan_Singh_Resume.pdf',DATE_SUB(NOW(),INTERVAL 6 DAY)),
((SELECT uid FROM user WHERE email='isha.thakur@demo.com'),'2012_1790002012_Isha_Thakur_Resume.pdf',DATE_SUB(NOW(),INTERVAL 3 DAY));

INSERT INTO skill (rid,skill)
SELECT r.rid,t.sk FROM (
SELECT 1 AS u,'android' AS sk UNION ALL SELECT 1,'kotlin' UNION ALL SELECT 1,'java' UNION ALL SELECT 1,'rest api' UNION ALL SELECT 1,'git' UNION ALL SELECT 1,'sql' UNION ALL SELECT 2,'flutter' UNION ALL SELECT 2,'android' UNION ALL SELECT 2,'git' UNION ALL SELECT 2,'rest api' UNION ALL SELECT 2,'javascript' UNION ALL SELECT 3,'php' UNION ALL SELECT 3,'mysql' UNION ALL SELECT 3,'sql' UNION ALL SELECT 3,'html' UNION ALL SELECT 3,'css' UNION ALL SELECT 3,'javascript' UNION ALL SELECT 3,'bootstrap' UNION ALL SELECT 4,'selenium' UNION ALL SELECT 4,'jira' UNION ALL SELECT 4,'python' UNION ALL SELECT 4,'java' UNION ALL SELECT 4,'sql' UNION ALL SELECT 4,'git' UNION ALL SELECT 5,'azure' UNION ALL SELECT 5,'docker' UNION ALL SELECT 5,'kubernetes' UNION ALL SELECT 5,'linux' UNION ALL SELECT 5,'git' UNION ALL SELECT 5,'python' UNION ALL SELECT 5,'aws' UNION ALL SELECT 6,'mongodb' UNION ALL SELECT 6,'express' UNION ALL SELECT 6,'react' UNION ALL SELECT 6,'nodejs' UNION ALL SELECT 6,'javascript' UNION ALL SELECT 6,'html' UNION ALL SELECT 6,'css' UNION ALL SELECT 6,'git' UNION ALL SELECT 7,'angular' UNION ALL SELECT 7,'typescript' UNION ALL SELECT 7,'javascript' UNION ALL SELECT 7,'html' UNION ALL SELECT 7,'css' UNION ALL SELECT 7,'bootstrap' UNION ALL SELECT 8,'python' UNION ALL SELECT 8,'sql' UNION ALL SELECT 8,'postgresql' UNION ALL SELECT 8,'aws' UNION ALL SELECT 8,'pandas' UNION ALL SELECT 8,'numpy' UNION ALL SELECT 9,'sql' UNION ALL SELECT 9,'tableau' UNION ALL SELECT 9,'power bi' UNION ALL SELECT 9,'excel' UNION ALL SELECT 9,'python' UNION ALL SELECT 10,'python' UNION ALL SELECT 10,'opencv' UNION ALL SELECT 10,'deep learning' UNION ALL SELECT 10,'pytorch' UNION ALL SELECT 10,'numpy' UNION ALL SELECT 10,'tensorflow' UNION ALL SELECT 11,'python' UNION ALL SELECT 11,'nlp' UNION ALL SELECT 11,'machine learning' UNION ALL SELECT 11,'pytorch' UNION ALL SELECT 11,'scikit-learn' UNION ALL SELECT 11,'pandas' UNION ALL SELECT 12,'python' UNION ALL SELECT 12,'fastapi' UNION ALL SELECT 12,'postgresql' UNION ALL SELECT 12,'docker' UNION ALL SELECT 12,'rest api' UNION ALL SELECT 12,'git' UNION ALL SELECT 12,'sql'
) t JOIN resume r ON SUBSTRING_INDEX(r.file,'_',1)=CONCAT('20',LPAD(t.u,2,'0'));

INSERT INTO matchresult (rid,jid,score,status,created_at)
SELECT r.rid,j.jid,t.sc,'Analyzed',r.upload_date FROM (
SELECT 1 AS u,1 AS j,13.63 AS sc UNION ALL SELECT 1,2,11.52 UNION ALL SELECT 1,3,44.94 UNION ALL SELECT 1,7,10.16 UNION ALL SELECT 1,8,38.09 UNION ALL SELECT 1,10,45.02 UNION ALL SELECT 1,11,10.16 UNION ALL SELECT 1,12,10.16 UNION ALL SELECT 1,13,84.66 UNION ALL SELECT 1,14,45.02 UNION ALL SELECT 1,16,22.58 UNION ALL SELECT 1,20,10.16 UNION ALL SELECT 1,21,11.52 UNION ALL SELECT 1,24,10.16 UNION ALL SELECT 2,4,12.74 UNION ALL SELECT 2,5,10.16 UNION ALL SELECT 2,8,11.23 UNION ALL SELECT 2,9,12.74 UNION ALL SELECT 2,10,12.74 UNION ALL SELECT 2,12,11.23 UNION ALL SELECT 2,13,43.16 UNION ALL SELECT 2,14,81.82 UNION ALL SELECT 2,15,11.23 UNION ALL SELECT 2,18,9.35 UNION ALL SELECT 2,19,11.23 UNION ALL SELECT 2,24,11.23 UNION ALL SELECT 3,1,12.54 UNION ALL SELECT 3,2,10.6 UNION ALL SELECT 3,3,16.17 UNION ALL SELECT 3,4,40.74 UNION ALL SELECT 3,5,45.03 UNION ALL SELECT 3,7,9.35 UNION ALL SELECT 3,8,9.35 UNION ALL SELECT 3,9,40.74 UNION ALL SELECT 3,10,10.6 UNION ALL SELECT 3,11,9.35 UNION ALL SELECT 3,15,74.74 UNION ALL SELECT 3,16,9.35 UNION ALL SELECT 3,18,27.52 UNION ALL SELECT 3,19,34.46 UNION ALL SELECT 3,20,9.35 UNION ALL SELECT 3,21,10.6 UNION ALL SELECT 4,1,31.88 UNION ALL SELECT 4,2,26.06 UNION ALL SELECT 4,3,44.94 UNION ALL SELECT 4,5,9.19 UNION ALL SELECT 4,6,9.19 UNION ALL SELECT 4,7,22.58 UNION ALL SELECT 4,8,38.09 UNION ALL SELECT 4,10,70.93 UNION ALL SELECT 4,11,22.58 UNION ALL SELECT 4,12,10.16 UNION ALL SELECT 4,13,22.58 UNION ALL SELECT 4,14,11.52 UNION ALL SELECT 4,16,84.66 UNION ALL SELECT 4,17,10.16 UNION ALL SELECT 4,20,22.58 UNION ALL SELECT 4,21,11.52 UNION ALL SELECT 4,22,10.16 UNION ALL SELECT 4,23,10.16 UNION ALL SELECT 4,24,10.16 UNION ALL SELECT 5,1,12.54 UNION ALL SELECT 5,2,10.6 UNION ALL SELECT 5,5,8.46 UNION ALL SELECT 5,6,8.46 UNION ALL SELECT 5,7,9.35 UNION ALL SELECT 5,8,20.61 UNION ALL SELECT 5,10,23.79 UNION ALL SELECT 5,11,9.35 UNION ALL SELECT 5,12,74.74 UNION ALL SELECT 5,13,9.35 UNION ALL SELECT 5,14,10.6 UNION ALL SELECT 5,16,9.35 UNION ALL SELECT 5,17,74.74 UNION ALL SELECT 5,20,20.61 UNION ALL SELECT 5,22,9.35 UNION ALL SELECT 5,23,9.35 UNION ALL SELECT 5,24,20.61 UNION ALL SELECT 6,4,57.97 UNION ALL SELECT 6,5,27.98 UNION ALL SELECT 6,9,57.97 UNION ALL SELECT 6,10,9.87 UNION ALL SELECT 6,12,8.7 UNION ALL SELECT 6,13,8.7 UNION ALL SELECT 6,14,9.87 UNION ALL SELECT 6,15,31.71 UNION ALL SELECT 6,18,88.31 UNION ALL SELECT 6,19,31.71 UNION ALL SELECT 7,4,45.02 UNION ALL SELECT 7,5,33.61 UNION ALL SELECT 7,9,45.02 UNION ALL SELECT 7,15,38.09 UNION ALL SELECT 7,18,30.41 UNION ALL SELECT 7,19,84.66 UNION ALL SELECT 8,1,31.88 UNION ALL SELECT 8,2,26.06 UNION ALL SELECT 8,3,17.58 UNION ALL SELECT 8,5,9.19 UNION ALL SELECT 8,6,33.61 UNION ALL SELECT 8,7,38.09 UNION ALL SELECT 8,8,22.58 UNION ALL SELECT 8,10,26.06 UNION ALL SELECT 8,11,22.58 UNION ALL SELECT 8,12,10.16 UNION ALL SELECT 8,16,22.58 UNION ALL SELECT 8,17,10.16 UNION ALL SELECT 8,20,84.66 UNION ALL SELECT 8,21,11.52 UNION ALL SELECT 8,22,22.58 UNION ALL SELECT 8,23,10.16 UNION ALL SELECT 8,24,22.58 UNION ALL SELECT 9,1,35.63 UNION ALL SELECT 9,2,29.12 UNION ALL SELECT 9,3,19.43 UNION ALL SELECT 9,5,10.16 UNION ALL SELECT 9,6,10.16 UNION ALL SELECT 9,7,66.94 UNION ALL SELECT 9,8,25.23 UNION ALL SELECT 9,10,29.12 UNION ALL SELECT 9,11,25.23 UNION ALL SELECT 9,16,25.23 UNION ALL SELECT 9,17,11.23 UNION ALL SELECT 9,20,25.23 UNION ALL SELECT 9,21,81.82 UNION ALL SELECT 9,22,11.23 UNION ALL SELECT 9,23,11.23 UNION ALL SELECT 9,24,11.23 UNION ALL SELECT 10,1,13.63 UNION ALL SELECT 10,2,11.52 UNION ALL SELECT 10,5,9.19 UNION ALL SELECT 10,6,50.31 UNION ALL SELECT 10,7,10.16 UNION ALL SELECT 10,8,10.16 UNION ALL SELECT 10,10,11.52 UNION ALL SELECT 10,11,10.16 UNION ALL SELECT 10,16,10.16 UNION ALL SELECT 10,17,10.16 UNION ALL SELECT 10,20,10.16 UNION ALL SELECT 10,22,84.66 UNION ALL SELECT 10,23,22.58 UNION ALL SELECT 10,24,10.16 UNION ALL SELECT 11,1,13.63 UNION ALL SELECT 11,2,11.52 UNION ALL SELECT 11,5,9.19 UNION ALL SELECT 11,6,33.61 UNION ALL SELECT 11,7,22.58 UNION ALL SELECT 11,8,10.16 UNION ALL SELECT 11,10,11.52 UNION ALL SELECT 11,11,38.09 UNION ALL SELECT 11,16,10.16 UNION ALL SELECT 11,17,10.16 UNION ALL SELECT 11,20,22.58 UNION ALL SELECT 11,22,22.58 UNION ALL SELECT 11,23,84.66 UNION ALL SELECT 11,24,10.16 UNION ALL SELECT 12,1,29.11 UNION ALL SELECT 12,2,23.79 UNION ALL SELECT 12,3,16.17 UNION ALL SELECT 12,5,8.46 UNION ALL SELECT 12,6,8.46 UNION ALL SELECT 12,7,20.61 UNION ALL SELECT 12,8,51.94 UNION ALL SELECT 12,10,40.74 UNION ALL SELECT 12,11,20.61 UNION ALL SELECT 12,12,20.61 UNION ALL SELECT 12,13,20.61 UNION ALL SELECT 12,14,23.79 UNION ALL SELECT 12,16,20.61 UNION ALL SELECT 12,17,20.61 UNION ALL SELECT 12,20,34.46 UNION ALL SELECT 12,21,10.6 UNION ALL SELECT 12,22,9.35 UNION ALL SELECT 12,23,9.35 UNION ALL SELECT 12,24,74.74
) t JOIN resume r ON SUBSTRING_INDEX(r.file,'_',1)=CONCAT('20',LPAD(t.u,2,'0')) JOIN jobdesc j ON j.jid=t.j+@off;

INSERT INTO matchresult (rid,jid,score,status,created_at)
SELECT r.rid,j.jid,t.sc,'Analyzed',r.upload_date FROM (
SELECT 1 AS u,13 AS j,17.86 AS sc UNION ALL SELECT 1,14,20.61 UNION ALL SELECT 1,15,43.93 UNION ALL SELECT 1,16,17.86 UNION ALL SELECT 1,17,8.18 UNION ALL SELECT 1,18,23.58 UNION ALL SELECT 1,19,29.53 UNION ALL SELECT 1,20,17.86 UNION ALL SELECT 1,21,9.27 UNION ALL SELECT 1,22,8.18 UNION ALL SELECT 1,23,8.18 UNION ALL SELECT 1,24,17.86 UNION ALL SELECT 2,16,16.84 UNION ALL SELECT 2,17,7.73 UNION ALL SELECT 2,20,27.74 UNION ALL SELECT 2,21,32.79 UNION ALL SELECT 2,22,16.84 UNION ALL SELECT 2,23,27.74 UNION ALL SELECT 2,24,7.73 UNION ALL SELECT 3,13,34.46 UNION ALL SELECT 3,14,23.79 UNION ALL SELECT 3,15,9.35 UNION ALL SELECT 3,16,20.61 UNION ALL SELECT 3,17,9.35 UNION ALL SELECT 3,20,9.35 UNION ALL SELECT 3,21,10.6 UNION ALL SELECT 3,24,20.61 UNION ALL SELECT 4,13,9.35 UNION ALL SELECT 4,14,10.6 UNION ALL SELECT 4,15,34.46 UNION ALL SELECT 4,18,55.86 UNION ALL SELECT 4,19,34.46 UNION ALL SELECT 5,16,8.18 UNION ALL SELECT 5,17,8.18 UNION ALL SELECT 5,20,17.86 UNION ALL SELECT 5,22,43.93 UNION ALL SELECT 5,23,29.53 UNION ALL SELECT 5,24,8.18 UNION ALL SELECT 6,16,22.58 UNION ALL SELECT 6,17,10.16 UNION ALL SELECT 6,20,38.09 UNION ALL SELECT 6,21,70.93 UNION ALL SELECT 6,22,10.16 UNION ALL SELECT 6,23,10.16 UNION ALL SELECT 6,24,10.16 UNION ALL SELECT 7,13,10.16 UNION ALL SELECT 7,14,11.52 UNION ALL SELECT 7,16,10.16 UNION ALL SELECT 7,17,58.03 UNION ALL SELECT 7,20,22.58 UNION ALL SELECT 7,22,10.16 UNION ALL SELECT 7,23,10.16 UNION ALL SELECT 7,24,22.58 UNION ALL SELECT 8,13,16.84 UNION ALL SELECT 8,14,19.43 UNION ALL SELECT 8,15,27.74 UNION ALL SELECT 8,16,16.84 UNION ALL SELECT 8,17,7.73 UNION ALL SELECT 8,18,22.15 UNION ALL SELECT 8,19,27.74 UNION ALL SELECT 8,20,27.74 UNION ALL SELECT 8,21,8.77 UNION ALL SELECT 8,22,7.73 UNION ALL SELECT 8,23,7.73 UNION ALL SELECT 8,24,27.74
) t JOIN resume r ON SUBSTRING_INDEX(r.file,'_',1)=CONCAT('10',t.u) JOIN jobdesc j ON j.jid=t.j+@off;

INSERT INTO feedback (uid,mid,rating,category,comment,placed_status,continue_status,submitted_at)
SELECT r.uid,m.mid,t.rating,t.cat,t.cm,t.pl,t.co,DATE_ADD(r.upload_date,INTERVAL 2 HOUR) FROM (
SELECT 1 AS u,13 AS j,5 AS rating,'Skill Detection' AS cat,'Android and Kotlin were detected correctly.' AS cm,'Searching' AS pl,'Continuing' AS co UNION ALL SELECT 3,15,4,'Job Matching Quality','PHP Developer role matched well with my skills.','Searching','Continuing' UNION ALL SELECT 4,16,3,'User Interface','Works fine, but the result page could show more charts.','Searching','Continuing' UNION ALL SELECT 5,17,5,'Job Matching Quality','Cloud Engineer match was spot on.','Placed','Continuing' UNION ALL SELECT 6,18,4,'Speed & Performance','Fast analysis and a clear list of missing skills.','Searching','Continuing' UNION ALL SELECT 8,20,5,'Job Matching Quality','Data Engineer role was ranked first, very useful.','Placed','Continuing' UNION ALL SELECT 9,21,2,'Skill Detection','It missed a few of my skills such as VBA.','Searching','Left' UNION ALL SELECT 10,22,5,'Skill Detection','Computer vision skills were detected perfectly.','Searching','Continuing' UNION ALL SELECT 11,23,4,'Other','Great project. Please add a resume improvement tips section.','Searching','Continuing' UNION ALL SELECT 12,24,5,'Job Matching Quality','FastAPI and PostgreSQL match gave a high score.','Placed','Continuing'
) t JOIN resume r ON SUBSTRING_INDEX(r.file,'_',1)=CONCAT('20',LPAD(t.u,2,'0')) JOIN matchresult m ON m.rid=r.rid AND m.jid=t.j+@off;

-- Check: after BOTH parts expect 20 users, 20 resumes, 24 jobs, 18 feedback
SELECT (SELECT COUNT(*) FROM user) users,(SELECT COUNT(*) FROM resume) resumes,(SELECT COUNT(*) FROM skill) skills,(SELECT COUNT(*) FROM jobdesc) jobs,(SELECT COUNT(*) FROM matchresult) matches,(SELECT COUNT(*) FROM feedback) feedback;