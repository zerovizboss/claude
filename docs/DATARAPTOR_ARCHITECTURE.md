# DataRaptor Architecture Design

## Overview
This document outlines the comprehensive DataRaptor structure for the OmniStudio Training Application, providing efficient data management for question banks, user progress tracking, exam results, and analytics.

## 1. Question Bank Management DataRaptors

### DR_Extract_Questions (DataRaptor Extract)
**Purpose:** Retrieve questions based on certification track, topic, and difficulty level

**Input Parameters:**
- `certificationTrack` (Text, Required): "Consultant" or "Developer"
- `topicArea` (Text, Optional): FlexCards, OmniScripts, DataTools, etc.
- `difficultyLevel` (Text, Optional): Beginner, Intermediate, Advanced
- `questionCount` (Number, Optional, Default: 20)
- `excludeQuestionIds` (Text, Optional): Comma-separated list of question IDs to exclude

**Extract Steps:**
- **GetQuestions**: Extracts from `Training_Question__c` with dynamic filtering
- **Output Fields**: Id, Question_Text__c, Option_A__c through Option_D__c, Correct_Answer__c, Explanation__c, Reference_URL__c, Topic_Area__c, Subtopic__c, Difficulty_Level__c, Question_Type__c, Exam_Weight__c
- **Features**: Random ordering, conditional filtering, active question validation

### DR_Turbo_Questions (DataRaptor Turbo Extract)
**Purpose:** High-performance question retrieval with user attempt history

**Input Parameters:**
- `examType` (Text, Required): Certification track
- `userId` (Text, Required): Current user ID

**Performance Features:**
- Custom SQL with LEFT JOIN for attempt history
- Prioritizes previously incorrect or unattempted questions
- Caching enabled with 5-minute TTL
- Optimized for 60-question exam loads

## 2. User Progress Management DataRaptors

### DR_Extract_UserProgress (DataRaptor Extract)
**Purpose:** Comprehensive user progress retrieval across all learning activities

**Extract Steps:**
1. **GetUserProfile**: User preferences and settings from `Training_User_Profile__c`
2. **GetTopicProgress**: Topic-specific mastery levels from `Topic_Progress__c`
3. **GetExamHistory**: Recent exam attempts from `Practice_Exam_Result__c`

**Output Structure:**
- User profile information (goals, experience, preferences)
- Topic-specific progress metrics
- Historical exam performance data

### DR_Transform_ProgressCalculation (DataRaptor Transform)
**Purpose:** Calculate weighted readiness scores and identify weak areas

**Transform Steps:**
1. **CalculateWeightedScore**: 
   - Consultant: FlexCards (23%) + OmniScripts (27%) + DataTools (23%) + Solutioning (27%)
   - Developer: Equal weighting across 5 topic areas (20% each)

2. **DetermineReadinessLevel**:
   - Exam Ready: 80%+
   - Almost Ready: 65-79%
   - Needs Practice: 50-64%
   - Beginner: <50%

3. **IdentifyWeakAreas**: Topics scoring below 60%
4. **EstimateStudyTime**: Recommended hours based on readiness level

### DR_Load_StudyProgress (DataRaptor Load)
**Purpose:** Persist study session data and update progress tracking

**Load Steps:**
1. **UpdateTopicProgress**: Upsert to `Topic_Progress__c` with cumulative metrics
2. **CreateStudySession**: Insert new session record to `Study_Session__c`

**Features:**
- Cumulative progress tracking
- Real-time mastery level calculation
- Session history maintenance

## 3. Exam Results Management DataRaptors

### DR_Transform_ExamResults (DataRaptor Transform)
**Purpose:** Process exam answers and calculate comprehensive results

**Transform Steps:**
1. **CalculateOverallScore**: Percentage based on correct answers
2. **DeterminePassStatus**: Pass/Fail based on 63% threshold
3. **CalculateTopicBreakdown**: Performance by topic area
4. **GenerateRecommendations**: Personalized next steps

**Analytics Features:**
- Topic-specific performance analysis
- Personalized feedback generation
- Historical comparison capabilities

### DR_Load_ExamResults (DataRaptor Load)
**Purpose:** Persist exam results and update user statistics

**Load Steps:**
1. **SaveExamResult**: Insert to `Practice_Exam_Result__c`
2. **UpdateUserStatistics**: Update cumulative stats in `Training_User_Profile__c`

**Tracked Metrics:**
- Total exams taken/passed
- Highest score achieved
- Last exam date
- Topic breakdown JSON

## 4. Analytics and Reporting DataRaptors

### DR_Extract_Analytics (DataRaptor Extract)
**Purpose:** Generate performance analytics and reporting data

**Report Types:**
1. **UserPerformance**: Individual user statistics and trends
2. **QuestionEffectiveness**: Question difficulty and success rates
3. **OverallStats**: Application-wide usage and performance metrics

**Features:**
- Configurable date ranges
- Aggregated statistics
- Performance benchmarking data

## 5. Custom Object Structure Requirements

### Training_Question__c
**Purpose:** Question bank storage with metadata

**Key Fields:**
- `Question_Text__c` (Long Text Area): Question content
- `Option_A__c` through `Option_D__c` (Text): Answer choices
- `Correct_Answer__c` (Picklist): A, B, C, D
- `Explanation__c` (Long Text Area): Detailed explanation
- `Reference_URL__c` (URL): Official documentation link
- `Topic_Area__c` (Picklist): Primary topic classification
- `Subtopic__c` (Text): Secondary classification
- `Difficulty_Level__c` (Picklist): Beginner, Intermediate, Advanced
- `Certification_Track__c` (Picklist): Consultant, Developer
- `Question_Type__c` (Picklist): Multiple Choice, Multiple Select, Scenario
- `Is_Active__c` (Checkbox): Question availability flag
- `Exam_Weight__c` (Number): Topic weighting percentage

### Training_User_Profile__c
**Purpose:** User preferences and cumulative statistics

**Key Fields:**
- `User__c` (Lookup): Salesforce User reference
- `Certification_Goals__c` (Multi-Picklist): Target certifications
- `Experience_Level__c` (Picklist): Salesforce experience level
- `Study_Hours_Per_Week__c` (Number): Available study time
- `Target_Exam_Date__c` (Date): Planned exam date
- `Preferred_Learning_Style__c` (Multi-Picklist): Learning preferences
- `Total_Exams_Taken__c` (Number): Cumulative exam count
- `Total_Exams_Passed__c` (Number): Passed exam count
- `Highest_Score__c` (Number): Best exam performance
- `Last_Exam_Date__c` (DateTime): Most recent exam
- `Last_Study_Session__c` (DateTime): Most recent study activity

### Topic_Progress__c
**Purpose:** Topic-specific learning progress tracking

**Key Fields:**
- `User__c` (Lookup): User reference
- `Topic_Area__c` (Text): Topic identifier
- `Certification_Track__c` (Picklist): Associated certification
- `Mastery_Level__c` (Number): Percentage mastery (0-100)
- `Questions_Attempted__c` (Number): Total questions tried
- `Questions_Correct__c` (Number): Correct answers
- `Time_Spent_Minutes__c` (Number): Study time investment
- `Last_Activity__c` (DateTime): Most recent activity
- `Readiness_Score__c` (Number): Exam readiness percentage

### Practice_Exam_Result__c
**Purpose:** Exam attempt results and performance history

**Key Fields:**
- `User__c` (Lookup): User reference
- `Exam_Score__c` (Number): Overall percentage score
- `Pass_Status__c` (Picklist): Pass/Fail result
- `Certification_Track__c` (Picklist): Exam type
- `Time_Taken_Minutes__c` (Number): Exam duration
- `Topic_Breakdown__c` (Long Text Area): JSON performance by topic
- `Exam_Date__c` (DateTime): Exam timestamp

### Study_Session__c
**Purpose:** Individual study session tracking

**Key Fields:**
- `User__c` (Lookup): User reference
- `Session_Type__c` (Picklist): Practice, Study Mode, Review
- `Questions_Attempted__c` (Number): Session question count
- `Questions_Correct__c` (Number): Correct answers in session
- `Duration_Minutes__c` (Number): Session length
- `Session_Date__c` (DateTime): Session timestamp
- `Topic_Focus__c` (Text): Primary topic studied

### User_Question_Attempt__c
**Purpose:** Individual question attempt tracking

**Key Fields:**
- `User__c` (Lookup): User reference
- `Question__c` (Lookup): Question reference
- `Selected_Answer__c` (Text): User's choice (A, B, C, D)
- `Is_Correct__c` (Checkbox): Answer correctness
- `Attempt_Date__c` (DateTime): Attempt timestamp
- `Time_Taken_Seconds__c` (Number): Time to answer
- `Session__c` (Lookup): Parent study session
- `Attempt_Count__c` (Number): Number of times attempted

## 6. Performance Optimization Guidelines

### Caching Strategy
- **DR_Turbo_Questions**: 5-minute cache for question sets
- **DR_Extract_Analytics**: 15-minute cache for dashboard data
- **Static content**: Long-term caching for reference materials

### Query Optimization
- **Indexed Fields**: User__c, Certification_Track__c, Topic_Area__c, Is_Active__c
- **Compound Indexes**: (User__c, Topic_Area__c, Certification_Track__c)
- **Query Limits**: Enforce reasonable limits on all extracts

### Data Archival
- **Exam Results**: Retain indefinitely for progress tracking
- **Study Sessions**: Archive sessions older than 2 years
- **Question Attempts**: Archive attempts older than 1 year (keep aggregated stats)

## 7. Integration Points

### FlexCard Integration
- **Dashboard Data**: DR_Extract_UserProgress
- **Progress Tracking**: DR_Transform_ProgressCalculation
- **Results Display**: DR_Transform_ExamResults

### OmniScript Integration
- **Question Delivery**: DR_Extract_Questions, DR_Turbo_Questions
- **Progress Saving**: DR_Load_StudyProgress
- **Results Processing**: DR_Load_ExamResults

### Integration Procedures
- **IP_GetUserProgress**: Calls DR_Extract_UserProgress + DR_Transform_ProgressCalculation
- **IP_ProcessExamResults**: Calls DR_Transform_ExamResults + DR_Load_ExamResults
- **IP_GetExamQuestions**: Calls DR_Turbo_Questions with user context

## 8. Error Handling and Monitoring

### Error Handling
- **Graceful Degradation**: Fallback to basic question sets if personalization fails
- **Data Validation**: Input parameter validation in all DataRaptors
- **Retry Logic**: Automatic retry for transient failures

### Monitoring
- **Performance Metrics**: Query execution times, cache hit rates
- **Usage Analytics**: DataRaptor execution frequency and patterns
- **Error Logging**: Comprehensive error tracking and alerting

This DataRaptor architecture provides a scalable, performant foundation for the OmniStudio Training Application, supporting both current requirements and future enhancements.