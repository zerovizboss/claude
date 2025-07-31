#!/bin/bash

# OmniStudio Training GitHub Issues Creation Script
# Run this script from your OmniStudio repository root directory

# First, create labels for organization
echo "Creating GitHub labels..."

gh label create "epic:foundation" --description "Project setup and architecture" --color "0052CC" --force
gh label create "epic:content" --description "Content strategy and question banks" --color "FF8B00" --force
gh label create "epic:flexcards" --description "FlexCard implementation" --color "36B37E" --force
gh label create "epic:omniscripts" --description "OmniScript workflows" --color "6554C0" --force
gh label create "epic:dataraptors" --description "Data management and DataRaptors" --color "FF5630" --force
gh label create "epic:integration" --description "Integration Procedures" --color "DE350B" --force
gh label create "epic:business-logic" --description "Business logic components" --color "8777D9" --force
gh label create "epic:qa" --description "Quality assurance and testing" --color "2684FF" --force
gh label create "epic:deployment" --description "Go-live preparation" --color "00875A" --force

gh label create "sprint-1" --description "Sprint 1 items" --color "F4F5F7" --force
gh label create "sprint-2" --description "Sprint 2 items" --color "F4F5F7" --force
gh label create "sprint-3" --description "Sprint 3 items" --color "F4F5F7" --force
gh label create "sprint-4" --description "Sprint 4 items" --color "F4F5F7" --force
gh label create "sprint-5" --description "Sprint 5 items" --color "F4F5F7" --force
gh label create "sprint-6" --description "Sprint 6 items" --color "F4F5F7" --force
gh label create "sprint-7" --description "Sprint 7 items" --color "F4F5F7" --force
gh label create "sprint-8" --description "Sprint 8 items" --color "F4F5F7" --force
gh label create "sprint-9" --description "Sprint 9 items" --color "F4F5F7" --force
gh label create "sprint-10" --description "Sprint 10 items" --color "F4F5F7" --force

gh label create "consultant-exam" --description "Consultant certification focus" --color "0747A6" --force
gh label create "developer-exam" --description "Developer certification focus" --color "0747A6" --force

gh label create "story-points:5" --description "5 story points" --color "C1C7D0" --force
gh label create "story-points:8" --description "8 story points" --color "C1C7D0" --force
gh label create "story-points:13" --description "13 story points" --color "C1C7D0" --force
gh label create "story-points:21" --description "21 story points" --color "C1C7D0" --force

echo "Labels created successfully!"

# Epic 1: Project Foundation
echo "Creating Epic 1 issues..."

gh issue create --title "Define project charter and technical architecture" --body "**As a** project manager
**I want** project charter and technical architecture defined
**So that** the development team has clear technical guidance and project scope

**Acceptance Criteria:**
- [ ] Technical architecture document created with OmniStudio component usage strategy
- [ ] Development environment requirements documented
- [ ] Project timeline and resource allocation planned
- [ ] Success metrics and KPIs defined
- [ ] Risk assessment and mitigation plan created

**Epic:** Project Foundation
**Sprint:** 1" --label "epic:foundation,sprint-1,story-points:8"

gh issue create --title "Setup development environment with OmniStudio components" --body "**As a** developer
**I want** development environment setup with OmniStudio components
**So that** I can begin building the training application

**Acceptance Criteria:**
- [ ] Salesforce DX project configured with API version 64.0
- [ ] OmniStudio package installed and configured
- [ ] Development org prepared with sample data
- [ ] CI/CD pipeline established with GitHub Actions
- [ ] Code quality tools configured (ESLint, Prettier)

**Epic:** Project Foundation
**Sprint:** 1" --label "epic:foundation,sprint-1,story-points:5"

gh issue create --title "Create wireframes and user experience design" --body "**As a** stakeholder
**I want** wireframes and user experience flows documented
**So that** I can visualize the application before development begins

**Acceptance Criteria:**
- [ ] User journey maps created for both certification tracks
- [ ] Wireframes designed for all major screens
- [ ] Mobile-responsive design specifications documented
- [ ] Accessibility requirements defined (WCAG 2.1 AA)
- [ ] Brand guidelines and visual design system established

**Epic:** Project Foundation
**Sprint:** 1" --label "epic:foundation,sprint-1,story-points:8"

# Epic 2: Content Strategy
echo "Creating Epic 2 issues..."

gh issue create --title "Develop question categorization framework for both exams" --body "**As a** content creator
**I want** question categorization framework for both exams
**So that** questions are properly organized and weighted according to official exam structure

**Acceptance Criteria:**
- [ ] Consultant exam topics mapped (FlexCards 23%, OmniScripts 27%, Data Tools 23%, Solutioning 27%)
- [ ] Developer exam topics mapped (FlexCards, OmniScripts, Integration Procedures, DataRaptors, Expressions)
- [ ] Question difficulty levels defined (Beginner, Intermediate, Advanced)
- [ ] Question type taxonomy created (Multiple Choice, Multiple Select, Scenario-based)
- [ ] Content tagging system implemented

**Epic:** Content Strategy
**Sprint:** 1" --label "epic:content,sprint-1,consultant-exam,developer-exam,story-points:5"

gh issue create --title "Create differentiated study paths for Consultant and Developer tracks" --body "**As a** learner
**I want** study paths differentiated between Consultant and Developer tracks
**So that** I can focus on content relevant to my chosen certification

**Acceptance Criteria:**
- [ ] Consultant learning path defined with role-specific scenarios
- [ ] Developer learning path defined with technical implementation focus
- [ ] Prerequisites and recommended experience documented for each path
- [ ] Study time estimates provided per topic
- [ ] Cross-certification mapping for users pursuing both certifications

**Epic:** Content Strategy
**Sprint:** 2" --label "epic:content,sprint-2,consultant-exam,developer-exam,story-points:8"

gh issue create --title "Implement weighted question distribution matching official exams" --body "**As an** exam candidate
**I want** weighted question distribution matching official exams
**So that** my practice experience accurately reflects the real certification exam

**Acceptance Criteria:**
- [ ] Question bank contains minimum 400 questions per certification
- [ ] Questions distributed according to official exam weightings
- [ ] Randomization algorithm ensures proper topic coverage
- [ ] Question pool regularly updated based on exam changes
- [ ] Analytics track question effectiveness and difficulty

**Epic:** Content Strategy
**Sprint:** 2" --label "epic:content,sprint-2,consultant-exam,developer-exam,story-points:13"

# Epic 3: FlexCard Implementation
echo "Creating Epic 3 issues..."

gh issue create --title "Build dashboard FlexCard with progress tracking" --body "**As a** learner
**I want** a dashboard FlexCard showing my progress across topics
**So that** I can track my certification preparation journey

**Acceptance Criteria:**
- [ ] FlexCard displays overall progress percentage with visual indicators
- [ ] Shows progress by exam type (Consultant/Developer) with separate metrics
- [ ] Displays weak areas needing attention with actionable recommendations
- [ ] Links to specific study modules and practice sessions
- [ ] Responsive design works on mobile, tablet, and desktop
- [ ] Real-time progress updates without page refresh

**Epic:** FlexCard Implementation
**Sprint:** 3" --label "epic:flexcards,sprint-3,story-points:8"

gh issue create --title "Create exam selection FlexCards for Consultant vs Developer" --body "**As a** user
**I want** exam selection FlexCards for Consultant vs Developer
**So that** I can choose my certification path with complete information

**Acceptance Criteria:**
- [ ] Two distinct FlexCards with unique visual styling for each certification
- [ ] Display exam details (60 questions, 105 minutes, 63% pass rate, $200 cost)
- [ ] Show recommended prerequisites and experience levels
- [ ] Navigation to appropriate study path and onboarding flow
- [ ] Visual differentiation between exam types using color coding
- [ ] Call-to-action buttons for \"Begin Study Path\" and \"Take Practice Exam\"

**Epic:** FlexCard Implementation
**Sprint:** 3" --label "epic:flexcards,sprint-3,consultant-exam,developer-exam,story-points:5"

gh issue create --title "Develop results summary FlexCards with performance analytics" --body "**As a** student
**I want** result summary FlexCards with performance analytics
**So that** I can understand my exam performance and areas for improvement

**Acceptance Criteria:**
- [ ] Pass/Fail status displayed with appropriate visual feedback
- [ ] Final score shown as percentage with passing threshold indicator
- [ ] Topic-by-topic breakdown with performance charts
- [ ] Recommendations for next steps based on results
- [ ] Option to retake exam or focus on weak areas
- [ ] Certificate download for passing scores
- [ ] Historical performance tracking

**Epic:** FlexCard Implementation
**Sprint:** 3" --label "epic:flexcards,sprint-3,story-points:8"

gh issue create --title "Build topic-specific progress FlexCards with drill-down capability" --body "**As a** learner
**I want** topic-specific progress FlexCards with drill-down capability
**So that** I can focus my studies on specific knowledge areas

**Acceptance Criteria:**
- [ ] Individual FlexCards for each major topic area
- [ ] Progress bars showing mastery level per topic
- [ ] Drill-down functionality to view subtopic performance
- [ ] Recommended study actions based on performance gaps
- [ ] Time spent studying per topic with efficiency metrics
- [ ] Comparison with average learner performance

**Epic:** FlexCard Implementation
**Sprint:** 4" --label "epic:flexcards,sprint-4,story-points:13"

echo "Issues for Epics 1-3 created! Continue with remaining epics..."
echo "To create all issues, run the remaining sections or create them manually using the GitHub_USER_STORIES_BACKLOG.md file."