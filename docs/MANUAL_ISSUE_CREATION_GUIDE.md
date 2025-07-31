# Manual GitHub Issues Creation Guide

Since you have the "OmniStudio Training" project linked to your Claude repository, here are the first 10 critical user stories formatted for manual creation in GitHub.

## How to Create Issues:

1. Go to: https://github.com/zerovizboss/claude/issues
2. Click "New Issue"
3. Copy and paste the title and body from each issue below
4. Add the specified labels
5. Assign to your "OmniStudio Training" project

## Labels to Create First:

Go to: https://github.com/zerovizboss/claude/labels

Create these labels:
- `epic:foundation` (blue #0052CC)
- `epic:content` (orange #FF8B00) 
- `epic:flexcards` (green #36B37E)
- `epic:omniscripts` (purple #6554C0)
- `sprint-1` through `sprint-10` (light gray #F4F5F7)
- `story-points:5`, `story-points:8`, `story-points:13`, `story-points:21` (gray #C1C7D0)
- `consultant-exam` and `developer-exam` (dark blue #0747A6)

---

## Issue 1: Define project charter and technical architecture

**Labels:** `epic:foundation`, `sprint-1`, `story-points:8`

**Title:** Define project charter and technical architecture

**Body:**
```
**As a** project manager
**I want** project charter and technical architecture defined
**So that** the development team has clear technical guidance and project scope

**Acceptance Criteria:**
- [ ] Technical architecture document created with OmniStudio component usage strategy
- [ ] Development environment requirements documented
- [ ] Project timeline and resource allocation planned
- [ ] Success metrics and KPIs defined
- [ ] Risk assessment and mitigation plan created

**Epic:** Project Foundation
**Sprint:** 1
**Story Points:** 8
```

---

## Issue 2: Setup development environment with OmniStudio components

**Labels:** `epic:foundation`, `sprint-1`, `story-points:5`

**Title:** Setup development environment with OmniStudio components

**Body:**
```
**As a** developer
**I want** development environment setup with OmniStudio components
**So that** I can begin building the training application

**Acceptance Criteria:**
- [ ] Salesforce DX project configured with API version 64.0
- [ ] OmniStudio package installed and configured
- [ ] Development org prepared with sample data
- [ ] CI/CD pipeline established with GitHub Actions
- [ ] Code quality tools configured (ESLint, Prettier)

**Epic:** Project Foundation
**Sprint:** 1
**Story Points:** 5
```

---

## Issue 3: Create wireframes and user experience design

**Labels:** `epic:foundation`, `sprint-1`, `story-points:8`

**Title:** Create wireframes and user experience design

**Body:**
```
**As a** stakeholder
**I want** wireframes and user experience flows documented
**So that** I can visualize the application before development begins

**Acceptance Criteria:**
- [ ] User journey maps created for both certification tracks
- [ ] Wireframes designed for all major screens
- [ ] Mobile-responsive design specifications documented
- [ ] Accessibility requirements defined (WCAG 2.1 AA)
- [ ] Brand guidelines and visual design system established

**Epic:** Project Foundation
**Sprint:** 1
**Story Points:** 8
```

---

## Issue 4: Develop question categorization framework for both exams

**Labels:** `epic:content`, `sprint-1`, `consultant-exam`, `developer-exam`, `story-points:5`

**Title:** Develop question categorization framework for both exams

**Body:**
```
**As a** content creator
**I want** question categorization framework for both exams
**So that** questions are properly organized and weighted according to official exam structure

**Acceptance Criteria:**
- [ ] Consultant exam topics mapped (FlexCards 23%, OmniScripts 27%, Data Tools 23%, Solutioning 27%)
- [ ] Developer exam topics mapped (FlexCards, OmniScripts, Integration Procedures, DataRaptors, Expressions)
- [ ] Question difficulty levels defined (Beginner, Intermediate, Advanced)
- [ ] Question type taxonomy created (Multiple Choice, Multiple Select, Scenario-based)
- [ ] Content tagging system implemented

**Epic:** Content Strategy
**Sprint:** 1
**Story Points:** 5
```

---

## Issue 5: Create differentiated study paths for Consultant and Developer tracks  

**Labels:** `epic:content`, `sprint-2`, `consultant-exam`, `developer-exam`, `story-points:8`

**Title:** Create differentiated study paths for Consultant and Developer tracks

**Body:**
```
**As a** learner
**I want** study paths differentiated between Consultant and Developer tracks
**So that** I can focus on content relevant to my chosen certification

**Acceptance Criteria:**
- [ ] Consultant learning path defined with role-specific scenarios
- [ ] Developer learning path defined with technical implementation focus
- [ ] Prerequisites and recommended experience documented for each path
- [ ] Study time estimates provided per topic
- [ ] Cross-certification mapping for users pursuing both certifications

**Epic:** Content Strategy
**Sprint:** 2
**Story Points:** 8
```

---

## Issue 6: Build dashboard FlexCard with progress tracking

**Labels:** `epic:flexcards`, `sprint-3`, `story-points:8`

**Title:** Build dashboard FlexCard with progress tracking

**Body:**
```
**As a** learner
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
**Sprint:** 3
**Story Points:** 8
```

---

## Issue 7: Create exam selection FlexCards for Consultant vs Developer

**Labels:** `epic:flexcards`, `sprint-3`, `consultant-exam`, `developer-exam`, `story-points:5`

**Title:** Create exam selection FlexCards for Consultant vs Developer

**Body:**
```
**As a** user
**I want** exam selection FlexCards for Consultant vs Developer
**So that** I can choose my certification path with complete information

**Acceptance Criteria:**
- [ ] Two distinct FlexCards with unique visual styling for each certification
- [ ] Display exam details (60 questions, 105 minutes, 63% pass rate, $200 cost)
- [ ] Show recommended prerequisites and experience levels
- [ ] Navigation to appropriate study path and onboarding flow
- [ ] Visual differentiation between exam types using color coding
- [ ] Call-to-action buttons for "Begin Study Path" and "Take Practice Exam"

**Epic:** FlexCard Implementation
**Sprint:** 3
**Story Points:** 5
```

---

## Issue 8: Build practice exam OmniScript with timed sessions

**Labels:** `epic:omniscripts`, `sprint-4`, `consultant-exam`, `developer-exam`, `story-points:13`

**Title:** Build practice exam OmniScript with timed sessions

**Body:**
```
**As an** exam candidate
**I want** practice exam OmniScripts with timed sessions
**So that** I can simulate real exam conditions

**Acceptance Criteria:**
- [ ] Timer functionality for 105-minute sessions with warnings at 15 and 5 minutes remaining
- [ ] 60 randomized questions from appropriate question bank
- [ ] Progress tracking during exam with question navigation
- [ ] Automatic submission when time expires
- [ ] Immediate score calculation and detailed feedback
- [ ] Review mode to see correct answers and explanations
- [ ] Ability to bookmark difficult questions for later review

**Epic:** OmniScript Workflows
**Sprint:** 4
**Story Points:** 13
```

---

## Issue 9: Create user onboarding OmniScript for learning preferences

**Labels:** `epic:omniscripts`, `sprint-4`, `story-points:8`

**Title:** Create user onboarding OmniScript for learning preferences

**Body:**
```
**As a** user
**I want** an onboarding OmniScript to set learning preferences
**So that** I receive personalized study recommendations

**Acceptance Criteria:**
- [ ] Collect user experience level (Salesforce and OmniStudio)
- [ ] Capture preferred learning style (questions, labs, videos, docs, simulations)
- [ ] Set study schedule preferences and available hours per week
- [ ] Choose target certification(s) and optional exam date
- [ ] Save preferences to user profile for personalization
- [ ] Generate personalized study plan based on inputs
- [ ] Mobile-friendly interface with progress indicators

**Epic:** OmniScript Workflows
**Sprint:** 4
**Story Points:** 8
```

---

## Issue 10: Implement weighted question distribution matching official exams

**Labels:** `epic:content`, `sprint-2`, `consultant-exam`, `developer-exam`, `story-points:13`

**Title:** Implement weighted question distribution matching official exams

**Body:**
```
**As an** exam candidate
**I want** weighted question distribution matching official exams
**So that** my practice experience accurately reflects the real certification exam

**Acceptance Criteria:**
- [ ] Question bank contains minimum 400 questions per certification
- [ ] Questions distributed according to official exam weightings
- [ ] Randomization algorithm ensures proper topic coverage
- [ ] Question pool regularly updated based on exam changes
- [ ] Analytics track question effectiveness and difficulty

**Epic:** Content Strategy
**Sprint:** 2
**Story Points:** 13
```

---

## Quick Project Setup:

1. **Create the labels** listed above first
2. **Create these 10 issues** by copying the title and body content
3. **Go to your project board:** https://github.com/zerovizboss/claude/projects
4. **Add all issues to the "OmniStudio Training" project**
5. **Organize by sprint columns:** Backlog → Sprint 1 → Sprint 2 → etc.

## Remaining Issues:

The complete backlog has 40 user stories. After creating these first 10, refer to `docs/GITHUB_USER_STORIES_BACKLOG.md` for the remaining 30 issues covering:

- Epic 5: DataRaptor Configuration (Sprint 4-5)
- Epic 6: Question Bank Development (Sprint 3-6) 
- Epic 7: Integration Procedures (Sprint 7-8)
- Epic 8: Business Logic Components (Sprint 7-8)
- Epic 9: Quality Assurance (Sprint 9-10)
- Epic 10: Go-Live Preparation (Sprint 9-10)

This should get your project board started with the most critical foundation issues!