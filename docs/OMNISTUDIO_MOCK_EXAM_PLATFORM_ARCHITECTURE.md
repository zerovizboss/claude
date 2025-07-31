# OmniStudio Mock Exam Platform - Component Architecture

## Platform Overview
This architecture defines OmniStudio components to create an interactive mock examination platform for OmniStudio Consultant and Developer certifications. The platform will use FlexCards, OmniScripts, Integration Procedures, and DataRaptors to deliver a comprehensive testing experience.

---

## ARCHITECTURE COMPONENTS

### 1. DATA MODEL DESIGN

#### Custom Objects

**ExamSession__c**
```
Fields:
- Name (Text) - Auto-generated session ID
- UserId__c (Lookup to User) - Test taker
- ExamType__c (Picklist) - "Consultant" or "Developer"
- StartTime__c (DateTime) - Session start
- EndTime__c (DateTime) - Session completion
- Status__c (Picklist) - "In Progress", "Completed", "Paused", "Abandoned"
- TotalQuestions__c (Number) - Questions in exam
- CorrectAnswers__c (Number) - Right answers
- ScorePercentage__c (Formula) - Final score
- TimeRemaining__c (Number) - Minutes left
- CurrentQuestionNumber__c (Number) - Progress tracker
```

**Question__c**
```
Fields:
- Name (Text) - Question ID
- QuestionText__c (Long Text Area) - Question content
- OptionA__c (Text) - Answer choice A
- OptionB__c (Text) - Answer choice B
- OptionC__c (Text) - Answer choice C
- OptionD__c (Text) - Answer choice D
- OptionE__c (Text) - Answer choice E (for multi-select)
- CorrectAnswers__c (Text) - Correct answer(s) - "A,C" for multi-select
- Explanation__c (Long Text Area) - Answer explanation
- ExamType__c (Picklist) - "Consultant", "Developer", "Both"
- Section__c (Picklist) - "FlexCards", "OmniScripts", "DataRaptors", etc.
- DifficultyLevel__c (Picklist) - "Beginner", "Intermediate", "Advanced"
- IsMultiSelect__c (Checkbox) - Multiple choice vs single
- IsScored__c (Checkbox) - Scored vs unscored questions
- QuestionOrder__c (Number) - Display sequence
```

**ExamResponse__c**
```
Fields:
- Name (Text) - Auto-generated response ID
- ExamSession__c (Lookup) - Parent session
- Question__c (Lookup) - Question answered
- UserAnswer__c (Text) - Selected answer(s)
- IsCorrect__c (Formula) - Answer correctness
- TimeSpent__c (Number) - Seconds on question
- ResponseTime__c (DateTime) - When answered
```

---

### 2. FLEXCARD DESIGNS

#### Main Exam Dashboard FlexCard

**Card Name:** `ExamDashboard`
**Purpose:** Landing page for exam selection and progress tracking

```json
{
  "name": "ExamDashboard",
  "dataSource": {
    "type": "Integration Procedure",
    "value": "GetUserExamHistory"
  },
  "cards": [
    {
      "title": "OmniStudio Certification Mock Exams",
      "sections": [
        {
          "name": "examOptions",
          "elements": [
            {
              "type": "button",
              "label": "Consultant Mock Exam",
              "styleClass": "consultant-exam-btn",
              "action": {
                "type": "OmniScript",
                "value": "StartConsultantExam"
              }
            },
            {
              "type": "button", 
              "label": "Developer Mock Exam",
              "styleClass": "developer-exam-btn",
              "action": {
                "type": "OmniScript",
                "value": "StartDeveloperExam"
              }
            }
          ]
        },
        {
          "name": "examHistory",
          "title": "Recent Exam Results",
          "elements": [
            {
              "type": "dataTable",
              "fields": [
                "ExamType__c",
                "ScorePercentage__c", 
                "CompletedDate__c",
                "Status__c"
              ],
              "actions": [
                {
                  "label": "Review Results",
                  "type": "FlexCard",
                  "value": "ExamResultsReview"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

#### Exam Question FlexCard

**Card Name:** `ExamQuestionCard`
**Purpose:** Display individual questions with answer options

```json
{
  "name": "ExamQuestionCard",
  "dataSource": {
    "type": "Integration Procedure", 
    "value": "GetCurrentQuestion"
  },
  "cards": [
    {
      "title": "Question {QuestionNumber} of {TotalQuestions}",
      "sections": [
        {
          "name": "examHeader",
          "elements": [
            {
              "type": "progressBar",
              "value": "{ProgressPercentage}",
              "label": "Progress"
            },
            {
              "type": "timer",
              "value": "{TimeRemaining}",
              "format": "mm:ss",
              "styleClass": "exam-timer"
            }
          ]
        },
        {
          "name": "questionContent", 
          "elements": [
            {
              "type": "text",
              "value": "{QuestionText__c}",
              "styleClass": "question-text"
            }
          ]
        },
        {
          "name": "answerOptions",
          "elements": [
            {
              "type": "radio",
              "name": "selectedAnswer",
              "options": [
                {"label": "{OptionA__c}", "value": "A"},
                {"label": "{OptionB__c}", "value": "B"}, 
                {"label": "{OptionC__c}", "value": "C"},
                {"label": "{OptionD__c}", "value": "D"}
              ],
              "conditionalView": "{IsMultiSelect__c} == false"
            },
            {
              "type": "checkbox",
              "name": "selectedAnswers",
              "options": [
                {"label": "{OptionA__c}", "value": "A"},
                {"label": "{OptionB__c}", "value": "B"},
                {"label": "{OptionC__c}", "value": "C"}, 
                {"label": "{OptionD__c}", "value": "D"},
                {"label": "{OptionE__c}", "value": "E"}
              ],
              "conditionalView": "{IsMultiSelect__c} == true"
            }
          ]
        },
        {
          "name": "navigationActions",
          "elements": [
            {
              "type": "button",
              "label": "Previous",
              "action": {
                "type": "Integration Procedure",
                "value": "NavigateToPreviousQuestion"
              },
              "conditionalView": "{CurrentQuestionNumber} > 1"
            },
            {
              "type": "button",
              "label": "Next", 
              "action": {
                "type": "Integration Procedure",
                "value": "SubmitAnswerAndNext"
              },
              "styleClass": "primary-btn"
            },
            {
              "type": "button",
              "label": "Submit Exam",
              "action": {
                "type": "Integration Procedure", 
                "value": "SubmitCompleteExam"
              },
              "conditionalView": "{CurrentQuestionNumber} == {TotalQuestions}",
              "styleClass": "submit-btn"
            }
          ]
        }
      ]
    }
  ]
}
```

#### Exam Results FlexCard

**Card Name:** `ExamResultsCard`
**Purpose:** Display comprehensive exam results and analysis

```json
{
  "name": "ExamResultsCard",
  "dataSource": {
    "type": "Integration Procedure",
    "value": "GetExamResults"
  },
  "cards": [
    {
      "title": "Exam Results - {ExamType__c} Certification",
      "sections": [
        {
          "name": "overallScore",
          "elements": [
            {
              "type": "scoreDisplay",
              "value": "{ScorePercentage__c}",
              "label": "Overall Score",
              "styleClass": "score-display-large"
            },
            {
              "type": "statusIndicator",
              "value": "{PassFailStatus}",
              "styleClass": "status-indicator"
            }
          ]
        },
        {
          "name": "sectionBreakdown",
          "title": "Section Performance",
          "elements": [
            {
              "type": "chartBar",
              "data": "{SectionScores}",
              "xAxis": "section",
              "yAxis": "score"
            }
          ]
        },
        {
          "name": "detailedAnalysis",
          "elements": [
            {
              "type": "accordion",
              "sections": [
                {
                  "title": "Incorrect Answers Review",
                  "content": "{IncorrectAnswersDetail}"
                },
                {
                  "title": "Study Recommendations", 
                  "content": "{StudyRecommendations}"
                },
                {
                  "title": "Time Analysis",
                  "content": "{TimeAnalysis}"
                }
              ]
            }
          ]
        },
        {
          "name": "nextSteps",
          "elements": [
            {
              "type": "button",
              "label": "Retake Exam",
              "action": {
                "type": "OmniScript",
                "value": "StartNewExam"
              }
            },
            {
              "type": "button",
              "label": "View Study Materials",
              "action": {
                "type": "FlexCard", 
                "value": "StudyResourcesCard"
              }
            }
          ]
        }
      ]
    }
  ]
}
```

---

### 3. OMNISCRIPTS

#### Exam Setup OmniScript

**Script Name:** `ExamSetup`
**Type:** Guided Process
**Sub Type:** Mock Exam
**Language:** English

**Step 1: Exam Selection**
```json
{
  "name": "ExamSelection", 
  "elements": [
    {
      "type": "Radio",
      "name": "ExamType",
      "label": "Select Certification Exam",
      "options": [
        {"label": "OmniStudio Consultant", "value": "Consultant"},
        {"label": "OmniStudio Developer", "value": "Developer"}
      ],
      "required": true
    },
    {
      "type": "Text",
      "name": "ExamInfo",
      "value": "This is a full-length practice exam with 60 scored questions plus 5 unscored questions. You have 105 minutes to complete.",
      "styleClass": "info-text"
    }
  ]
}
```

**Step 2: Instructions**
```json
{
  "name": "ExamInstructions",
  "elements": [
    {
      "type": "Display Text",
      "value": "EXAM INSTRUCTIONS",
      "styleClass": "header-text"
    },
    {
      "type": "Display Text", 
      "value": "• You have 105 minutes to complete 65 questions\n• Questions are randomly selected from the question bank\n• You can navigate between questions using Previous/Next\n• Your progress is automatically saved\n• Review all questions before submitting"
    },
    {
      "type": "Checkbox",
      "name": "AgreementConfirm",
      "label": "I understand the exam instructions and am ready to begin",
      "required": true
    }
  ]
}
```

**Step 3: Exam Launch**
```json
{
  "name": "ExamLaunch",
  "elements": [
    {
      "type": "Integration Procedure Action",
      "name": "InitializeExam",
      "integrationProcedureKey": "InitializeExamSession",
      "inputMap": {
        "ExamType": "%ExamType%",
        "UserId": "%UserId%"
      }
    },
    {
      "type": "Display Text",
      "value": "Your exam session has been initialized. Click 'Start Exam' to begin.",
      "conditionalView": "%InitializeExam:success% == true"
    }
  ],
  "actions": [
    {
      "name": "StartExam",
      "type": "Navigate", 
      "target": "FlexCard:ExamQuestionCard"
    }
  ]
}
```

---

### 4. INTEGRATION PROCEDURES

#### Initialize Exam Session

**Name:** `InitializeExamSession`
**Purpose:** Create exam session and select random questions

**Elements:**
1. **DataRaptor Extract Action**
   - Name: GetQuestionPool
   - Input: ExamType, DifficultyLevel
   - Output: Available questions list

2. **Set Values** 
   - Name: RandomizeQuestions
   - Logic: Shuffle question order, select 60 scored + 5 unscored

3. **DataRaptor Load Action**
   - Name: CreateExamSession
   - Object: ExamSession__c
   - Fields: UserId__c, ExamType__c, StartTime__c, Status__c

4. **Response Action**
   - Name: ReturnSessionData
   - Output: SessionId, FirstQuestionId, TotalQuestions

#### Get Current Question

**Name:** `GetCurrentQuestion`
**Purpose:** Retrieve question data for display

**Elements:**
1. **DataRaptor Extract Action**
   - Name: GetSessionData
   - Input: SessionId
   - Output: Current question number, session status

2. **DataRaptor Extract Action**  
   - Name: GetQuestionData
   - Input: QuestionId
   - Output: Question text, options, metadata

3. **Set Values**
   - Name: CalculateProgress
   - Logic: Progress percentage, time remaining

4. **Response Action**
   - Name: ReturnQuestionData
   - Output: Question details, progress info, navigation options

#### Submit Answer and Navigate

**Name:** `SubmitAnswerAndNext`
**Purpose:** Save answer and move to next question

**Elements:**
1. **DataRaptor Load Action**
   - Name: SaveResponse
   - Object: ExamResponse__c
   - Fields: ExamSession__c, Question__c, UserAnswer__c, ResponseTime__c

2. **Set Values**
   - Name: UpdateSessionProgress
   - Logic: Increment question counter, update timestamp

3. **Conditional Block**
   - Name: CheckIfComplete
   - Condition: CurrentQuestion == TotalQuestions
   - True: Call CompleteExam procedure
   - False: Load next question

4. **DataRaptor Extract Action**
   - Name: GetNextQuestion
   - Input: SessionId, NextQuestionNumber
   - Output: Next question data

#### Complete Exam Session

**Name:** `CompleteExamSession`
**Purpose:** Calculate final score and generate results

**Elements:**
1. **DataRaptor Extract Action**
   - Name: GetAllResponses
   - Input: SessionId
   - Output: All user responses for scoring

2. **Set Values**
   - Name: CalculateScore
   - Logic: Compare answers, calculate percentage, determine pass/fail

3. **DataRaptor Transform Action**
   - Name: GenerateResults
   - Input: Responses, correct answers
   - Output: Section scores, time analysis, recommendations

4. **DataRaptor Load Action**
   - Name: UpdateSession
   - Object: ExamSession__c
   - Fields: EndTime__c, Status__c, ScorePercentage__c, CorrectAnswers__c

---

### 5. DATARAPTORS

#### Extract: Get Question Pool

**Name:** `DR_GetQuestionPool`
**Type:** Extract
**Object:** Question__c

**Query Filters:**
- ExamType__c = Input.ExamType OR ExamType__c = 'Both'
- IsActive__c = true

**Output Fields:**
- Id, Name, QuestionText__c, OptionA__c through OptionE__c
- CorrectAnswers__c, Explanation__c, Section__c
- DifficultyLevel__c, IsMultiSelect__c, IsScored__c

#### Transform: Calculate Exam Results

**Name:** `DR_CalculateExamResults`
**Type:** Transform
**Input:** Exam responses and correct answers

**Transformation Logic:**
```json
{
  "transformations": [
    {
      "name": "ScoreCalculation",
      "formula": "ROUND((CorrectCount / TotalScoredQuestions) * 100, 0)"
    },
    {
      "name": "SectionScores", 
      "formula": "GROUP BY Section, CALCULATE percentage per section"
    },
    {
      "name": "TimeAnalysis",
      "formula": "AVERAGE time per question, identify slow areas"
    },
    {
      "name": "StudyRecommendations",
      "formula": "IF score < 70% in section, recommend focused study"
    }
  ]
}
```

#### Load: Create Exam Session

**Name:** `DR_CreateExamSession`  
**Type:** Load
**Object:** ExamSession__c

**Field Mappings:**
- UserId__c ← Input.UserId
- ExamType__c ← Input.ExamType  
- StartTime__c ← NOW()
- Status__c ← 'In Progress'
- TotalQuestions__c ← Input.QuestionCount

---

### 6. MOBILE RESPONSIVENESS

#### FlexCard Mobile Optimization
```css
@media (max-width: 768px) {
  .exam-question-card {
    padding: 10px;
    font-size: 16px;
  }
  
  .answer-options {
    margin: 15px 0;
  }
  
  .navigation-buttons {
    position: fixed;
    bottom: 0;
    width: 100%;
    background: white;
    padding: 10px;
    box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
  }
  
  .exam-timer {
    position: fixed;
    top: 10px;
    right: 10px;
    background: rgba(255,255,255,0.9);
    padding: 5px 10px;
    border-radius: 5px;
  }
}
```

---

### 7. SECURITY AND COMPLIANCE

#### Data Security Measures
- Field-level security on Question__c correct answers
- Record-level security for exam sessions
- Audit trail for all exam activities
- Session timeout after 105 minutes
- Prevention of multiple concurrent sessions

#### Compliance Features
- GDPR-compliant data handling
- Exam session data retention policies
- User consent tracking
- Anonymous performance analytics
- Secure transmission of all data

---

### 8. PERFORMANCE OPTIMIZATION

#### Caching Strategy
- Question pool cached per exam type
- User session data cached during exam
- Results cached for 30 days
- Static resources (images, CSS) cached

#### Database Optimization
- Indexed fields: ExamSession__c.UserId__c, Question__c.ExamType__c
- Selective SOQL queries with field limits
- Bulk operations for question loading
- Asynchronous result calculation for large datasets

---

### 9. ANALYTICS AND REPORTING

#### Built-in Analytics
- Question difficulty analysis based on success rates
- Time-per-question analytics
- Section performance trends
- Pass/fail rate tracking
- User engagement metrics

#### Reporting Dashboard
- Real-time exam statistics
- Question bank effectiveness
- User progress tracking
- Certification readiness indicators
- Performance benchmarking

---

This architecture provides a comprehensive foundation for building an interactive OmniStudio mock exam platform using native Salesforce and OmniStudio components. The modular design allows for iterative development and easy enhancement of features.