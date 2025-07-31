# FlexCard Implementation Plan - Mock Exam Testing Interface

## Implementation Overview
This document provides a detailed implementation plan for creating FlexCards that deliver an interactive mock examination testing interface for OmniStudio certifications.

---

## PHASE 1: FOUNDATION FLEXCARDS

### 1.1 Exam Dashboard FlexCard

**FlexCard Name:** `MockExamDashboard`
**Implementation Priority:** P0 - Critical
**Development Time:** 2-3 days

#### JSON Configuration
```json
{
  "name": "MockExamDashboard",
  "description": "Main landing page for OmniStudio mock exams",
  "author": "OmniStudio Training Team",
  "version": "1.0",
  "dataSource": {
    "type": "Integration Procedure",
    "value": "GetUserExamDashboardData",
    "timeout": 30000,
    "options": {
      "cacheable": true,
      "cacheTimeout": 300
    }
  },
  "states": [
    {
      "name": "default",
      "conditions": "true"
    }
  ],
  "layout": {
    "template": "responsive",
    "size": "large",
    "columns": 2,
    "mobileColumns": 1
  },
  "cards": [
    {
      "cardKey": "examOptions",
      "title": "OmniStudio Certification Practice",
      "subtitle": "Choose your certification path",
      "styleClass": "exam-dashboard-main",
      "sections": [
        {
          "name": "consultantSection",
          "title": "Consultant Certification",
          "styleClass": "consultant-section",
          "elements": [
            {
              "type": "text",
              "value": "Test your knowledge of OmniStudio solution design, requirements gathering, and best practices.",
              "styleClass": "section-description"
            },
            {
              "type": "stats",
              "layout": "horizontal",
              "stats": [
                {
                  "label": "Questions",
                  "value": "65",
                  "icon": "utility:questions_and_answers"
                },
                {
                  "label": "Time Limit", 
                  "value": "105 min",
                  "icon": "utility:clock"
                },
                {
                  "label": "Pass Score",
                  "value": "63%",
                  "icon": "utility:success"
                }
              ]
            },
            {
              "type": "actionButton",
              "label": "Start Consultant Exam",
              "variant": "brand",
              "size": "large",
              "fullWidth": true,
              "action": {
                "type": "OmniScript",
                "value": "MockExam_Setup_English",
                "params": {
                  "examType": "Consultant"
                }
              }
            }
          ]
        },
        {
          "name": "developerSection", 
          "title": "Developer Certification",
          "styleClass": "developer-section",
          "elements": [
            {
              "type": "text",
              "value": "Focus on technical implementation, configuration, and advanced OmniStudio development techniques.",
              "styleClass": "section-description"
            },
            {
              "type": "stats",
              "layout": "horizontal", 
              "stats": [
                {
                  "label": "Questions",
                  "value": "65",
                  "icon": "utility:questions_and_answers"
                },
                {
                  "label": "Time Limit",
                  "value": "105 min", 
                  "icon": "utility:clock"
                },
                {
                  "label": "Pass Score",
                  "value": "65%",
                  "icon": "utility:success"
                }
              ]
            },
            {
              "type": "actionButton",
              "label": "Start Developer Exam",
              "variant": "brand",
              "size": "large", 
              "fullWidth": true,
              "action": {
                "type": "OmniScript",
                "value": "MockExam_Setup_English",
                "params": {
                  "examType": "Developer"
                }
              }
            }
          ]
        }
      ]
    },
    {
      "cardKey": "examHistory",
      "title": "Your Exam History",
      "subtitle": "Track your progress and improvements",
      "styleClass": "exam-history",
      "conditionalView": "%UserExamHistory:length% > 0",
      "sections": [
        {
          "name": "recentResults",
          "elements": [
            {
              "type": "dataTable",
              "data": "%UserExamHistory%",
              "maxRows": 5,
              "columns": [
                {
                  "field": "ExamType__c",
                  "label": "Exam Type",
                  "type": "text"
                },
                {
                  "field": "ScorePercentage__c",
                  "label": "Score",
                  "type": "badge",
                  "conditions": [
                    {
                      "condition": "value >= 90",
                      "styleClass": "slds-theme_success"
                    },
                    {
                      "condition": "value >= 70",
                      "styleClass": "slds-theme_warning"
                    },
                    {
                      "condition": "value < 70",
                      "styleClass": "slds-theme_error"
                    }
                  ]
                },
                {
                  "field": "CompletedDate__c",
                  "label": "Date",
                  "type": "date"
                },
                {
                  "field": "actions",
                  "label": "Actions",
                  "type": "actions",
                  "actions": [
                    {
                      "label": "View Details",
                      "icon": "utility:preview",
                      "action": {
                        "type": "FlexCard",
                        "value": "ExamResultsDetail",
                        "params": {
                          "sessionId": "{Id}"
                        }
                      }
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ],
  "styling": {
    "customCSS": "exam-dashboard-styles.css"
  }
}
```

#### Custom CSS (exam-dashboard-styles.css)
```css
.exam-dashboard-main {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 12px;
  padding: 24px;
}

.consultant-section {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 16px;
  border-left: 4px solid #00d4aa;
}

.developer-section {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 16px;
  border-left: 4px solid #ff6b6b;
}

.section-description {
  font-size: 14px;
  opacity: 0.9;
  margin-bottom: 16px;
}

.exam-history {
  background: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  border-radius: 8px;
}

@media (max-width: 768px) {
  .exam-dashboard-main {
    padding: 16px;
  }
  
  .consultant-section,
  .developer-section {
    padding: 16px;
  }
}
```

### 1.2 Question Display FlexCard

**FlexCard Name:** `ExamQuestionInterface`
**Implementation Priority:** P0 - Critical
**Development Time:** 3-4 days

#### JSON Configuration
```json
{
  "name": "ExamQuestionInterface",
  "description": "Interactive question display and answer interface",
  "version": "1.0",
  "dataSource": {
    "type": "Integration Procedure",
    "value": "GetCurrentExamQuestion",
    "timeout": 10000,
    "params": {
      "sessionId": "%ContextId%"
    }
  },
  "layout": {
    "template": "single",
    "size": "full-width"
  },
  "cards": [
    {
      "cardKey": "questionCard",
      "title": "Question %CurrentQuestionNumber% of %TotalQuestions%",
      "styleClass": "question-interface",
      "sections": [
        {
          "name": "examHeader",
          "styleClass": "exam-header",
          "elements": [
            {
              "type": "progressIndicator",
              "value": "%ProgressPercentage%",
              "variant": "base",
              "size": "large",
              "label": "Progress: %ProgressPercentage%%"
            },
            {
              "type": "timer",
              "value": "%TimeRemaining%",
              "format": "HH:mm:ss",
              "styleClass": "exam-timer",
              "warningTime": 300,
              "criticalTime": 60,
              "onExpire": {
                "action": {
                  "type": "Integration Procedure",
                  "value": "AutoSubmitExam"
                }
              }
            }
          ]
        },
        {
          "name": "questionContent",
          "styleClass": "question-content",
          "elements": [
            {
              "type": "text",
              "value": "%QuestionText__c%",
              "styleClass": "question-text",
              "allowHTML": true
            },
            {
              "type": "image",
              "value": "%QuestionImage__c%",
              "conditionalView": "%QuestionImage__c% != null",
              "styleClass": "question-image",
              "alt": "Question diagram"
            }
          ]
        },
        {
          "name": "answerOptions",
          "styleClass": "answer-section",
          "elements": [
            {
              "type": "radioGroup",
              "name": "singleAnswer",
              "conditionalView": "%IsMultiSelect__c% == false",
              "options": [
                {
                  "label": "A) %OptionA__c%",
                  "value": "A",
                  "conditionalView": "%OptionA__c% != null"
                },
                {
                  "label": "B) %OptionB__c%",
                  "value": "B", 
                  "conditionalView": "%OptionB__c% != null"
                },
                {
                  "label": "C) %OptionC__c%",
                  "value": "C",
                  "conditionalView": "%OptionC__c% != null"
                },
                {
                  "label": "D) %OptionD__c%",
                  "value": "D",
                  "conditionalView": "%OptionD__c% != null"
                }
              ],
              "value": "%UserAnswer%",
              "styleClass": "answer-options"
            },
            {
              "type": "checkboxGroup",
              "name": "multipleAnswers",
              "conditionalView": "%IsMultiSelect__c% == true",
              "options": [
                {
                  "label": "A) %OptionA__c%",
                  "value": "A",
                  "conditionalView": "%OptionA__c% != null"
                },
                {
                  "label": "B) %OptionB__c%",
                  "value": "B",
                  "conditionalView": "%OptionB__c% != null"
                },
                {
                  "label": "C) %OptionC__c%",
                  "value": "C",
                  "conditionalView": "%OptionC__c% != null"
                },
                {
                  "label": "D) %OptionD__c%",
                  "value": "D",
                  "conditionalView": "%OptionD__c% != null"
                },
                {
                  "label": "E) %OptionE__c%",
                  "value": "E",
                  "conditionalView": "%OptionE__c% != null"
                }
              ],
              "value": "%UserAnswers%",
              "styleClass": "answer-options"
            }
          ]
        },
        {
          "name": "questionInfo",
          "styleClass": "question-meta",
          "elements": [
            {
              "type": "badge",
              "value": "%Section__c%",
              "variant": "inverse",
              "label": "Section"
            },
            {
              "type": "badge", 
              "value": "%DifficultyLevel__c%",
              "variant": "outline-brand",
              "label": "Difficulty"
            },
            {
              "type": "text",
              "value": "Multiple Select",
              "conditionalView": "%IsMultiSelect__c% == true",
              "styleClass": "multi-select-indicator"
            }
          ]
        },
        {
          "name": "navigationControls",
          "styleClass": "navigation-section",
          "elements": [
            {
              "type": "buttonGroup",
              "alignment": "space-between",
              "buttons": [
                {
                  "label": "⬅ Previous",
                  "variant": "neutral",
                  "disabled": "%CurrentQuestionNumber% <= 1",
                  "action": {
                    "type": "Integration Procedure",
                    "value": "NavigateToQuestion",
                    "params": {
                      "direction": "previous",
                      "sessionId": "%SessionId%"
                    }
                  }
                },
                {
                  "label": "Mark for Review",
                  "variant": "outline-brand",
                  "icon": "utility:bookmark",
                  "action": {
                    "type": "Integration Procedure",  
                    "value": "MarkQuestionForReview",
                    "params": {
                      "questionId": "%QuestionId%",
                      "sessionId": "%SessionId%"
                    }
                  }
                },
                {
                  "label": "Next ➡",
                  "variant": "brand",
                  "conditionalView": "%CurrentQuestionNumber% < %TotalQuestions%",
                  "action": {
                    "type": "Integration Procedure",
                    "value": "SaveAnswerAndNavigate",
                    "params": {
                      "direction": "next",
                      "answer": "%singleAnswer% || %multipleAnswers%",
                      "sessionId": "%SessionId%"
                    }
                  }
                },
                {
                  "label": "Submit Exam",
                  "variant": "destructive",
                  "conditionalView": "%CurrentQuestionNumber% == %TotalQuestions%",
                  "action": {
                    "type": "OmniScript",
                    "value": "ExamSubmission_Confirmation_English",
                    "params": {
                      "sessionId": "%SessionId%"
                    }
                  }
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

---

## PHASE 2: ADVANCED FLEXCARDS

### 2.1 Question Navigation FlexCard

**FlexCard Name:** `ExamNavigationMap`
**Implementation Priority:** P1 - High
**Development Time:** 2 days

```json
{
  "name": "ExamNavigationMap",
  "description": "Visual navigation map showing all questions and their status",
  "dataSource": {
    "type": "Integration Procedure",
    "value": "GetExamNavigationData"
  },
  "cards": [
    {
      "cardKey": "navigationMap",
      "title": "Question Overview",
      "sections": [
        {
          "name": "questionGrid",
          "elements": [
            {
              "type": "grid",
              "data": "%QuestionList%",
              "columns": 10,
              "items": [
                {
                  "type": "button",
                  "label": "%QuestionNumber%",
                  "size": "small",
                  "variant": "neutral",
                  "styleClass": "nav-question-btn %Status%",
                  "action": {
                    "type": "Integration Procedure",
                    "value": "NavigateToSpecificQuestion",
                    "params": {
                      "questionNumber": "%QuestionNumber%"
                    }
                  }
                }
              ]
            }
          ]
        },
        {
          "name": "legend",
          "elements": [
            {
              "type": "legend",
              "items": [
                {"color": "#4CAF50", "label": "Answered"},
                {"color": "#FFC107", "label": "Marked for Review"},
                {"color": "#F44336", "label": "Not Answered"},
                {"color": "#2196F3", "label": "Current Question"}
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

### 2.2 Exam Results Dashboard

**FlexCard Name:** `ExamResultsDashboard`
**Implementation Priority:** P1 - High
**Development Time:** 3 days

```json
{
  "name": "ExamResultsDashboard",
  "description": "Comprehensive results analysis with charts and recommendations",
  "dataSource": {
    "type": "Integration Procedure", 
    "value": "GenerateExamResults"
  },
  "cards": [
    {
      "cardKey": "resultsOverview",
      "title": "%ExamType% Mock Exam Results",
      "sections": [
        {
          "name": "scoreDisplay",
          "elements": [
            {
              "type": "scoreCard",
              "score": "%OverallScore%",
              "maxScore": 100,
              "passingScore": "%PassingScore%",
              "label": "Your Score",
              "size": "large",
              "showPercentage": true,
              "animation": true
            },
            {
              "type": "statusBadge",
              "value": "%PassFailStatus%",
              "variant": "%PassFailStatus% == 'PASS' ? 'success' : 'error'",
              "size": "large"
            }
          ]
        },
        {
          "name": "sectionBreakdown",
          "title": "Performance by Section",
          "elements": [
            {
              "type": "chartBar",
              "data": "%SectionScores%",
              "xAxis": "section",
              "yAxis": "percentage",
              "threshold": "%PassingScore%",
              "colors": ["#4CAF50", "#FFC107", "#F44336"],
              "responsive": true
            }
          ]
        },
        {
          "name": "detailedAnalysis",
          "elements": [
            {
              "type": "accordion",
              "allowMultiple": true,
              "sections": [
                {
                  "title": "Incorrect Answers (%IncorrectCount%)",
                  "icon": "utility:error",
                  "content": {
                    "type": "dataTable",
                    "data": "%IncorrectQuestions%",
                    "columns": [
                      {"field": "QuestionNumber", "label": "#"},
                      {"field": "Section__c", "label": "Section"},
                      {"field": "YourAnswer", "label": "Your Answer"},
                      {"field": "CorrectAnswer", "label": "Correct Answer"},
                      {"field": "Explanation__c", "label": "Explanation"}
                    ]
                  }
                },
                {
                  "title": "Time Analysis",
                  "icon": "utility:clock",
                  "content": {
                    "type": "statsGrid",
                    "stats": [
                      {"label": "Total Time", "value": "%TotalTime%"},
                      {"label": "Average per Question", "value": "%AvgTimePerQuestion%"},
                      {"label": "Longest Question", "value": "%LongestQuestionTime%"},
                      {"label": "Shortest Question", "value": "%ShortestQuestionTime%"}
                    ]
                  }
                },
                {
                  "title": "Study Recommendations",
                  "icon": "utility:knowledge_base",
                  "content": {
                    "type": "list",
                    "items": "%StudyRecommendations%",
                    "variant": "ordered"
                  }
                }
              ]
            }
          ]
        },
        {
          "name": "nextSteps",
          "title": "Next Steps",
          "elements": [
            {
              "type": "buttonGroup",
              "buttons": [
                {
                  "label": "Retake Exam",
                  "variant": "brand",
                  "icon": "utility:refresh",
                  "action": {
                    "type": "OmniScript",
                    "value": "MockExam_Setup_English",
                    "params": {
                      "examType": "%ExamType%"
                    }
                  }
                },
                {
                  "label": "Study Resources",
                  "variant": "neutral",
                  "icon": "utility:knowledge_base",
                  "action": {
                    "type": "FlexCard",
                    "value": "StudyResourcesCard"
                  }
                },
                {
                  "label": "Download Results",
                  "variant": "outline-brand",
                  "icon": "utility:download",
                  "action": {
                    "type": "Integration Procedure",
                    "value": "GenerateResultsPDF"
                  }
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

---

## PHASE 3: IMPLEMENTATION DETAILS

### 3.1 Data Source Integration

#### Integration Procedure Mappings
```json
{
  "GetUserExamDashboardData": {
    "purpose": "Load dashboard data including user history",
    "caching": "5 minutes",
    "errorHandling": "graceful degradation"
  },
  "GetCurrentExamQuestion": {
    "purpose": "Retrieve current question and session state",
    "caching": "none",
    "errorHandling": "retry with exponential backoff"
  },
  "SaveAnswerAndNavigate": {
    "purpose": "Save user response and move to next question",
    "caching": "none",
    "errorHandling": "critical error handling"
  }
}
```

### 3.2 Mobile Optimization

#### Responsive Design Patterns
```css
/* Mobile-first approach */
.question-interface {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
}

@media (max-width: 768px) {
  .exam-header {
    flex-direction: column;
    align-items: center;
  }
  
  .exam-timer {
    position: fixed;
    top: 10px;
    right: 10px;
    z-index: 1000;
    background: rgba(255,255,255,0.95);
    padding: 8px 12px;
    border-radius: 6px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
  }
  
  .answer-options {
    padding: 0 16px;
  }
  
  .navigation-section {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: white;
    padding: 16px;
    box-shadow: 0 -2px 8px rgba(0,0,0,0.1);
    z-index: 999;
  }
  
  .question-content {
    margin-bottom: 120px; /* Space for fixed navigation */
  }
}
```

### 3.3 Performance Optimization

#### Loading Strategies
- **Lazy Loading:** Load questions on-demand
- **Prefetching:** Pre-load next 2-3 questions in background
- **Caching:** Cache question data for session duration
- **Image Optimization:** Compress and serve images via CDN

#### Data Management
```javascript
// Prefetch next questions
const prefetchQuestions = async (currentIndex, totalQuestions) => {
  const prefetchCount = Math.min(3, totalQuestions - currentIndex);
  for (let i = 1; i <= prefetchCount; i++) {
    if (currentIndex + i <= totalQuestions) {
      // Prefetch logic
      await loadQuestion(currentIndex + i);
    }
  }
};
```

### 3.4 Accessibility Features

#### WCAG 2.1 Compliance
- **Keyboard Navigation:** Full keyboard support
- **Screen Reader:** ARIA labels and descriptions
- **Color Contrast:** Minimum 4.5:1 ratio
- **Focus Management:** Clear focus indicators
- **Alternative Text:** All images have alt text

```html
<!-- Example accessible question option -->
<div class="answer-option" role="radio" aria-checked="false" tabindex="0">
  <input type="radio" id="option-a" name="question-answer" value="A" aria-describedby="option-a-desc">
  <label for="option-a" class="option-label">
    <span class="option-letter">A)</span>
    <span class="option-text" id="option-a-desc">DataRaptor Extract only works with Salesforce data</span>
  </label>
</div>
```

---

## PHASE 4: TESTING AND VALIDATION

### 4.1 Unit Testing
- Individual FlexCard component testing
- Data source integration testing
- Action handler testing
- Error condition testing

### 4.2 Integration Testing  
- Full exam flow testing
- Navigation testing
- Timer functionality testing
- Results calculation testing

### 4.3 User Acceptance Testing
- Usability testing with target users
- Mobile device testing
- Accessibility testing
- Performance testing under load

### 4.4 Browser Compatibility
- Chrome (latest 2 versions)
- Firefox (latest 2 versions)
- Safari (latest 2 versions)
- Edge (latest 2 versions)
- Mobile browsers (iOS Safari, Chrome Mobile)

---

## DEPLOYMENT CHECKLIST

### Pre-Deployment
- [ ] All FlexCards tested and validated
- [ ] Integration Procedures deployed and tested
- [ ] Custom CSS uploaded and linked
- [ ] Data model deployed with test data
- [ ] Security settings configured
- [ ] Analytics tracking enabled

### Post-Deployment
- [ ] Smoke testing in production
- [ ] Performance monitoring active
- [ ] User access verified
- [ ] Backup procedures tested
- [ ] Support documentation complete

This implementation plan provides a comprehensive roadmap for creating professional-grade FlexCards that deliver an engaging mock exam experience using OmniStudio components.