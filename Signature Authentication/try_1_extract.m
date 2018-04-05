[llq lhq hlq hhq]=dwt2(att1,'haar');
[LL_1q, HL_1q, LH_1q, HH_1q] = dwt2(llq, 'haar');    % 1st step DWT
[LL_2q, HL_2q, LH_2q, HH_2q] = dwt2(LL_1q, 'haar');  % 2nd step DWT
[LL_3q, HL_3q, LH_3q, HH_3q] = dwt2(LL_2q, 'haar');  % 3rd step DWT
[LL_4q, HL_4q, LH_4q, HH_4q] = dwt2(LL_3q, 'haar');  % 4rth step DWT

% [llq1 lhq1 hlq1 hhq1]=dwt2(att2,'haar');
% [LL_1q1, HL_1q1, LH_1q1, HH_1q1] = dwt2(llq1, 'haar');    % 1st step DWT
% [LL_2q1, HL_2q1, LH_2q1, HH_2q1] = dwt2(LL_1q1, 'haar');  % 2nd step DWT
% [LL_3q1, HL_3q1, LH_3q1, HH_3q1] = dwt2(LL_2q1, 'haar');  % 3rd step DWT
% [LL_4q1, HL_4q1, LH_4q1, HH_4q1] = dwt2(LL_3q1, 'haar');  % 4rth step DWT

% [llq2 lhq2 hlq2 hhq2]=dwt2(att2,'haar');
% [LL_1q2, HL_1q2, LH_1q2, HH_1q2] = dwt2(llq2, 'haar');    % 1st step DWT
% [LL_2q2, HL_2q2, LH_2q2, HH_2q2] = dwt2(LL_1q2, 'haar');  % 2nd step DWT
% [LL_3q2, HL_3q2, LH_3q2, HH_3q2] = dwt2(LL_2q2, 'haar');  % 3rd step DWT
% [LL_4q2, HL_4q2, LH_4q2, HH_4q2] = dwt2(LL_3q2, 'haar');  % 4rth step DWT
% 
% [llq3 lhq3 hlq3 hhq3]=dwt2(att3,'haar');
% [LL_1q3, HL_1q3, LH_1q3, HH_1q3] = dwt2(llq3, 'haar');    % 1st step DWT
% [LL_2q3, HL_2q3, LH_2q3, HH_2q3] = dwt2(LL_1q3, 'haar');  % 2nd step DWT
% [LL_3q3, HL_3q3, LH_3q3, HH_3q3] = dwt2(LL_2q3, 'haar');  % 3rd step DWT
% [LL_4q3, HL_4q3, LH_4q3, HH_4q3] = dwt2(LL_3q3, 'haar');  % 4rth step DWT
% 
% [llq4 lhq4 hlq4 hhq4]=dwt2(att4,'haar');
% [LL_1q4, HL_1q4, LH_1q4, HH_1q4] = dwt2(llq4, 'haar');    % 1st step DWT
% [LL_2q4, HL_2q4, LH_2q4, HH_2q4] = dwt2(LL_1q4, 'haar');  % 2nd step DWT
% [LL_3q4, HL_3q4, LH_3q4, HH_3q4] = dwt2(LL_2q4, 'haar');  % 3rd step DWT
% [LL_4q4, HL_4q4, LH_4q4, HH_4q4] = dwt2(LL_3q4, 'haar');  % 4rth step DWT
% 
% [llq5 lhq5 hlq5 hhq5]=dwt2(att5,'haar');
% [LL_1q5, HL_1q5, LH_1q5, HH_1q5] = dwt2(llq5, 'haar');    % 1st step DWT
% [LL_2q5, HL_2q5, LH_2q5, HH_2q5] = dwt2(LL_1q5, 'haar');  % 2nd step DWT
% [LL_3q5, HL_3q5, LH_3q5, HH_3q5] = dwt2(LL_2q5, 'haar');  % 3rd step DWT
% [LL_4q5, HL_4q5, LH_4q5, HH_4q5] = dwt2(LL_3q5, 'haar');  % 4rth step DWT

fin_ans=signature_extraction(LL_4q,HH_4q,8);
% fin_ans1=signature_extraction(LL_4q1,HH_4q1,8);
% fin_ans2=signature_extraction(LL_4q2,HH_4q2,8);
% fin_ans3=signature_extraction(LL_4q3,HH_4q3,8);
% fin_ans4=signature_extraction(LL_4q4,HH_4q4,8);
% fin_ans5=signature_extraction(LL_4q5,HH_4q5,8);