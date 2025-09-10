# Coding Agent Instructions

## Business Context

[TODO: Add your business context here]

### Core Features

[TODO: Add your core features here]

### Target Audience

[TODO: Add your target audience here]

## Technology Stack

### Core Framework

- **Framework:** Ruby on Rails 8.0.0 (Edge)
- **Language:** Ruby 3.4.4
- **Database:** PostgreSQL (Primary, SolidQueue, SolidCache, SolidCable), Redis (Dev ActionCable)
- **Web Server:** Puma

### Frontend Technologies

- **Hotwire:** Turbo + Stimulus for SPA-like interactions
- **CSS Framework:** Tailwind CSS
- **JavaScript:** Importmap/Propshaft
- **Components:** ViewComponent (`app/components`)

### Key Dependencies

- **Authentication:** Rails 8 Auth generator (Users + Teams)
- **Authorization:** Pundit (`app/policies`)
- **Background Jobs:** SolidQueue
- **Admin Interface:** Administrate
- **AI Features:** RubyLLM, OpenAI, Anthropic
- **Communication:** Postmark (Email), Twilio (SMS)
- **Testing:** RSpec, FactoryBot, Capybara, Selenium, WebMock, VCR

## Icon Usage Guidelines

### Icon Preference Order

1. HeroIcons - https://heroicons.com

## Code Style and Structure

### Ruby and Rails Conventions

- Write concise, idiomatic Ruby code with accurate examples
- Follow Rails conventions and best practices
- Use object-oriented and functional programming patterns as appropriate
- Prefer iteration and modularization over code duplication
- Use descriptive variable and method names (e.g., `user_signed_in?`, `calculate_total`)
- Structure files according to Rails conventions (MVC, concerns, helpers, etc.)
- Prefer double-quoted strings unless you need single quotes to avoid extra backslashes for escaping

### Naming Conventions

- Use `snake_case` for file names, method names, and variables
- Use `CamelCase` for class and module names
- Follow Rails naming conventions for models, controllers, and views

### Clean Code Guidelines

#### Constants Over Magic Numbers

- Replace hard-coded values with named constants
- Use descriptive constant names that explain the value's purpose
- Keep constants at the top of the file or in a dedicated constants file

#### Meaningful Names

- Variables, functions, and classes should reveal their purpose
- Names should explain why something exists and how it's used
- Avoid abbreviations unless they're universally understood

#### Smart Comments

- Don't comment on what the code does - make the code self-documenting
- Use comments to explain why something is done a certain way
- Document APIs, complex algorithms, and non-obvious side effects

#### Single Responsibility

- Each function should do exactly one thing
- Functions should be small and focused
- If a function needs a comment to explain what it does, it should be split

## Application Architecture

### Extended Structure

The application uses additional patterns beyond standard Rails MVC:

- `app/services/`: Service Objects for complex business logic
- `app/queries/`: Complex data retrieval logic
- `app/forms/`: Form Objects
- `app/policies/`: Pundit authorization policies
- `app/components/`: ViewComponent classes
- `app/jobs/`: Sidekiq job definitions
- `app/validators/`: Custom validations
- `app/dashboards/`: Administrate Dashboards
- `app/javascript/controllers/`: Stimulus controllers

### Service Objects

Use service objects to:

- Make controllers simple
- Perform complex operations
- Make the code more DRY (if a complex operation is needed in more than one place)
- Make calls to external APIs
- When using the Service concern, services should no be instantiated, but used with the .run class method

### View Components

Use ViewComponents to:

- Create more reusable pieces of UI
- Encapsulate logic in UI components
- Avoid littering standard Rails view files with complex logic
- Create methods in Ruby files for component behavior

## Testing Approach

### Testing Commands

Run individual test files using:

```bash
# Run specific spec file
bin/rspec spec/models/user_spec.rb

# Run specific test
bin/rspec spec/models/user_spec.rb:25

# Run all tests
bin/rspec
```

### RSpec Best Practices

- Write comprehensive tests using RSpec
- Prefer request specs rather than system tests
- Follow TDD/BDD practices
- Use factories (FactoryBot) for test data generation
- Use `let` to define test data
- Keep tests short and concise
- **Don't test `assigns`** - test rendered content instead
  - ❌ `expect(assigns(:records)).to include(record)`
  - ✅ `expect(response.body).to include(record.name)`

### Test Structure

- Write tests before fixing bugs
- Keep tests readable and maintainable
- Test edge cases and error conditions

### Rails 8 Testing Best Practices

#### Test Pyramid (Guideline)
- Most tests should be **isolated specs** for services, models, and ViewComponents.
- **Request specs** are the preferred integration layer — hit real routing + DB and assert JSON/Turbo Stream responses.
- **System tests** are usually for key paths (signup, payments, core workflows), kept minimal and fast. Complex UI features that rely on JavaScript should have 1 happy and 1 sad path system test.

#### Principles
- **Outside-in**: Start with a request or component/system spec; drive behavior into small POROs; mock only at boundaries (HTTP, Stripe), never internals.
- **Small steps**: One assertion concept per example; refactor relentlessly.
- **Confidence focus**: High-value flows get end-to-end coverage; most wiring bugs caught by request/component specs.
- **Don't test private methods**: Assert behavior through public APIs. If a unit has complex internals worth testing, extract a PORO with a public interface and test that instead.

#### Rails-Specific Practices
- **Models**: Use shoulda-matchers for validations/associations; test only your business logic.
- **Services/Queries**: Pure POROs; mock only external boundaries.
- **Policies**: Unit test predicates; a few request specs for integration (403s).
- **ViewComponents**: Test rendering + key text/ARIA; for Hotwire, assert Turbo Stream payloads in request specs.
- **Hotwire/Stimulus**:
  1. Component spec — HTML/data-controller wiring.
  2. Request spec — correct Turbo Stream response.
  3. One JS-enabled system test — happy-path smoke.

#### What to Assert
- Status, schema/shape of JSON, Turbo Stream target/action, jobs enqueued, emails sent, DB changes.
- Webhooks: Verify signature; use real sample payloads from fixtures.

#### Request Spec Scope (keep examples minimal)
- Default to a small set of examples per endpoint (3–4 total):
  - Happy path (200/201)
  - Permissions/authorization failure when applicable (401/403)
  - Validation failure for representative invalid input (422)
  - Optional: Not found (404) only if behavior is non-standard
- Avoid enumerating minor parameter variations at the request level. Cover permutations and edge cases in smaller unit/service specs.
- Prefer clarity over volume; use shared examples sparingly for repeated permission/validation checks.

#### Test Data & Speed
- Lean factories; `build_stubbed` for unit; `create` only if DB matters.
- Traits over callbacks; add `FactoryBot.lint` to CI.
- Parallelize specs; use `freeze_time`; disable external HTTP via WebMock/VCR.

#### Coverage & CI
- SimpleCov with a sensible threshold; profile slowest specs; fix flakes at root cause.

#### Legacy Code
- Add characterization tests first; introduce seams; slice into POROs; replace with narrower tests after refactor.

---
**TL;DR**: Prefer request specs for integration, lean heavily on fast isolated specs for core logic, and keep system tests sparse — only for critical paths that truly need end-to-end verification.

## Frontend Development

### Hotwire (Turbo + Stimulus)

- Use Hotwire for dynamic, SPA-like interactions
- Implement Turbo Frames for partial page updates
- Use Turbo Streams for real-time updates
- Create Stimulus controllers for JavaScript behavior

### Tailwind CSS Best Practices

- Use utility classes over custom CSS
- Group related utilities with @apply when needed
- Use proper responsive design utilities
- Implement mobile-first approach
- Use semantic color naming
- Keep component styles consistent
- Use proper responsive breakpoints
- Follow naming conventions

### UI Design System & Styling Conventions

Based on established patterns in the application, follow these consistent styling conventions:

#### Color Palette & Branding

**Primary Colors:**
- Primary action buttons: `bg-blue-600` with `hover:bg-blue-700`
- Primary focus states: `focus:ring-2 focus:ring-blue-500`
- Primary text links: `text-blue-600 hover:text-blue-900`

**Status Colors:**
- Success/Completed: `bg-green-100 text-green-800`
- Warning/Pending: `bg-yellow-100 text-yellow-800`
- Info/Processing: `bg-blue-100 text-blue-800`
- Error/Failed: `bg-red-100 text-red-800`
- Neutral/Default: `bg-gray-100 text-gray-800`

#### Typography System

**Headings:**
- Page titles (H1): `text-2xl font-semibold text-gray-900 mb-2`
- Section headings (H2): `text-lg font-medium text-gray-900`
- Subsection headings (H3): `text-base font-medium text-gray-900`

**Body Text:**
- Primary text: `text-gray-900` (for important content)
- Secondary text: `text-gray-600` (for descriptions, captions)
- Tertiary text: `text-gray-500` (for metadata, timestamps)
- Muted text: `text-gray-400` (for placeholders, disabled states)

**Text Sizes:**
- Small text: `text-sm`
- Extra small: `text-xs`
- Button text: `font-medium`

#### Layout & Spacing

**Container Patterns:**
- Main content width: `max-w-6xl mx-auto`
- Standard spacing: `mb-8` (between major sections), `mb-6` (between subsections)
- Grid layouts: `grid gap-8 lg:grid-cols-2` (for two-column layouts)

**Card Components:**
- Standard card: `bg-white border border-gray-200 rounded-lg shadow-sm p-6`
- Hover states: `hover:bg-gray-50` (for interactive cards)
- Card sections: `border-b border-gray-200` (for dividing sections)

#### Form Elements

**Input Fields:**
- Standard input: `w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent`
- Labels: `block text-sm font-medium text-gray-700 mb-2`
- Helper text: `text-sm text-gray-500`

**Buttons:**
- Primary button: `flex items-center gap-2 px-8 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors`
- Disabled state: `disabled:opacity-50 disabled:cursor-not-allowed`
- Button with icon: Include `gap-2` and size-5 icons

#### Interactive Elements

**Drag & Drop Zones:**
- Border: `border-2 border-dashed border-gray-300`
- Hover state: `hover:border-blue-400 hover:bg-gray-50`
- Active styling: `rounded-lg p-8 text-center cursor-pointer transition-colors`

**File Items/List Items:**
- Container: `flex items-center justify-between p-3 bg-gray-50 rounded-lg border`
- Icon spacing: `flex items-center space-x-3`
- Action buttons: `text-gray-400 hover:text-red-500 transition-colors`

#### Tables & Data Display

**Table Structure:**
- Table: `min-w-full divide-y divide-gray-200`
- Header: `bg-gray-50`
- Header cells: `px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider`
- Body cells: `px-6 py-4 whitespace-nowrap`
- Row hover: `hover:bg-gray-50`

**Status Badges:**
- Base: `px-2 inline-flex text-xs leading-5 font-semibold rounded-full`
- Apply status-specific background/text color classes

#### Icons & Visual Elements

**Icon Guidelines:**
- Standard size: `h-5 w-5` (20px)
- Small icons: `h-4 w-4` (16px)
- Large decorative: `h-10 w-10` (40px)
- Icon colors: `text-gray-400` (default), `text-gray-500` (interactive)

#### States & Interactions

**Loading/Progress:**
- Progress bars: `w-full bg-blue-200 rounded-full h-2` with `bg-blue-600 h-2 rounded-full`
- Loading containers: `bg-blue-50 rounded-lg border border-blue-200`

**Empty States:**
- Text: `text-center py-8 text-gray-500`

#### Responsive Design

**Breakpoints:**
- Use `lg:` prefix for large screens (desktop-first approach)
- Default mobile-first styling
- Grid responsive: `lg:grid-cols-2` for desktop, single column on mobile

### Creating Index Tables (Best Practices)

When creating index pages with tables, follow these patterns for consistency:

#### Controller Pattern

Implement consistent controller patterns:

```ruby
def index
  authorize ModelName

  @tab = params[:tab] || "all"

  query = current_account
    .model_names
    .includes(:associations)

  # Filter by status if not "all" tab (assumes tab names match enum values)
  query = query.where(status: @tab) unless @tab == "all"

  query = query.order(created_at: :desc)

  @pagy, @records = pagy(
    query,
    page: params[:page],
    trim_extra: false,
    limit_extra: true
  )
end
```

#### CSS Classes Reference

**Content Styling:**

- `text-sm text-gray-900` - Primary text content
- `text-xs text-gray-500` - Secondary/subtitle text
- `text-xs text-gray-400` - Tertiary/timestamp text
- `max-w-md truncate` - Truncate long text with max width
- `mt-0.5` - Small spacing between stacked content

#### Status Badge Components

Create dedicated status badge components:

```ruby
class ModelName::StatusBadgeComponent < ApplicationComponent
  def initialize(record)
    @record = record
  end

  def call
    color = {
      pending: "blue",
      success: "green",
      failed: "orange",
      error: "red"
    }.fetch(@record.status.to_sym, "gray")

    tooltip_text = @record.status_message if @record.status_message.present?

    render Ui::BadgeComponent.new(@record.status.titlecase, color, tooltip: tooltip_text)
  end
end
```

This pattern ensures consistent table layouts, proper CSS usage, and maintainable code structure across all index pages.

## Security and Performance

### Security

- Implement proper authentication and authorization (Devise, Pundit)
- Use strong parameters in controllers
- Protect against common web vulnerabilities (XSS, CSRF, SQL injection)

### Performance Optimization

- Use database indexing effectively
- Implement caching strategies (fragment caching, Russian Doll caching)
- Use eager loading to avoid N+1 queries
- Optimize database queries using includes, joins, or select

## Error Handling

- Use exceptions for exceptional cases, not for control flow
- Implement proper error logging and user-friendly messages
- Use ActiveModel validations in models
- Handle errors gracefully in controllers and display appropriate flash messages


## Development Workflow

### Running the Application

- Use `bin/dev` (Overmind/Foreman) to run development processes
- Follow `README.md` instructions for setup

### Code Quality

- Use Rubocop for linting with autofix: `bin/rubocop -A`
- Use ERB-Lint for ERB files: `bundle exec erblint`
- Run tests frequently: `bin/rspec`

### Debugging and Development

- Use `rails console` for interactive debugging
- Use `binding.irb` for breakpoints in development
- Check logs in `log/development.log`
- Use Rails generators for scaffolding: `rails g model`, `rails g controller`

### Testing Patterns & Practices

#### Test Organization Best Practices

**Factory Management:**
- Lean factories; `build_stubbed` for unit tests; `create` only if DB matters
- Use traits over callbacks for factory variations
- Add `FactoryBot.lint` to CI to catch factory issues early
- Keep factories minimal - only include required attributes by default

**Test Data & Performance:**
- Parallelize specs for faster execution
- Use `freeze_time` for consistent time-based testing
- Disable external HTTP via WebMock/VCR for reliable tests
- Mock only at boundaries (HTTP, external services), never internals

**Test Structure Guidelines:**
- One assertion concept per example; refactor relentlessly
- Keep test descriptions clear and behavior-focused
- Use `let` for lazy-loaded test data
- Group related tests in `context` blocks with clear descriptions

#### Service & Component Testing

**Services (following Service concern patterns):**
- Test class methods (`.run`) not instance methods for Service concern
- Mock external dependencies but avoid deep mocking
- Use the service matchers from `spec/support/matchers/services.rb`
- Don't create specs for private methods - test through public interface

**ViewComponents:**
- Test rendering + key text/ARIA attributes
- For Hotwire components, assert Turbo Stream payloads in request specs
- Component spec for HTML/data-controller wiring
- Keep component tests focused on rendering behavior

**Models:**
- Use shoulda-matchers for validations/associations
- Test only custom business logic, not Rails functionality
- Focus on edge cases and business rules

#### Integration Testing Strategy

**Request Specs (Primary Integration Layer):**
- Default to 3-4 examples per endpoint:
  - Happy path (200/201)
  - Authentication/authorization failure (401/403)
  - Validation failure for invalid input (422)
  - Not found (404) only if behavior is non-standard
- Assert status, JSON schema/shape, Turbo Stream target/action
- Test jobs enqueued, emails sent, DB changes
- Keep examples minimal - avoid minor parameter variations

**System Tests (Minimal Usage):**
- Only for critical paths needing end-to-end verification
- JavaScript-dependent features: 1 happy path, 1 sad path
- Focus on key workflows (signup, payments, core features)

#### What to Assert

- **API Responses:** Status codes, JSON structure, error messages
- **Turbo Streams:** Target elements, action types, content updates
- **Background Jobs:** Proper job enqueueing with expected arguments
- **Database Changes:** Record creation, updates, state transitions
- **External Services:** Proper API calls made (via mocking)
- **User Experience:** Flash messages, redirects, rendered content

#### Advanced Testing Patterns

**Webhooks:**
- Verify signature validation
- Use real sample payloads from fixtures
- Test both successful processing and error handling

**Time-Dependent Code:**
- Use `freeze_time` for consistent results
- Test edge cases around time boundaries
- Mock time-sensitive external API responses

**Multi-Tenant Testing:**
- Ensure proper tenant scoping in all tests
- Test cross-tenant data isolation
- Use appropriate tenant context in factory setup


## Claude Code Specific Guidelines

### File Operations

- Always read existing files before making changes to understand current patterns
- Prefer editing existing files over creating new ones
- Follow existing code patterns and conventions found in the codebase

### Testing

- Run tests after making changes: `bin/rspec`
- Write tests for new functionality
- Use existing test patterns found in `spec/` directory
- When creating specs for services that use the Service concern, use the matchers on spec/support/matchers/services.rb
- Do not create specs for services private methods

### Debugging

- Check current working directory and file structure using available tools
- Use search tools to understand how similar functionality is implemented
- Look at related files to understand patterns and conventions

### Test Environment and Code Quality Requirements

You have access to a full test environment and should always ensure code quality before finishing work:

#### Test Requirements

- Always write and run RSpec specs for new functionality
- Prefer request specs over system tests for better performance and reliability
- Use existing test patterns and factories found in the codebase
- Run `bin/rspec` to execute tests and verify functionality
- Tests must pass before work is considered complete

#### Code Quality

- Always run `bin/rubocop -A` before finishing work to fix linting errors
- This command will automatically fix most linting issues
- Ensure all linting errors are resolved before submitting changes
- Code quality checks are mandatory, not optional

#### Standard Workflow

1. Implement functionality
2. Write comprehensive RSpec tests (preferring request specs)
3. Run `bin/rspec` to verify tests pass
4. Run `bin/rubocop -A` to fix linting issues
5. Re-run tests if linting changes affected functionality
6. Only consider work complete when both tests pass and linting is clean

When suggesting code, always consider the business context and follow the established patterns and conventions outlined above.

## Lessons from Experience

These insights come from practical development work and complement the instructional guidelines above.

### Code Review Feedback

- **PR reviews often highlight patterns already in the codebase** - When reviewers suggest using specific validators or patterns, check how similar functionality is implemented elsewhere
- **Security concerns are iterative** - Address immediate concerns but recognize that comprehensive security often requires multiple layers
- **Don't over-engineer security** - Match the security level to what's already established in the codebase

### Refactoring Strategies

- **Controller complexity is a common code smell** - Actions over 20-30 lines often indicate business logic that belongs elsewhere
- **Service objects are powerful for complex operations** - They isolate business logic, improve testability, and make controllers thin
- **Extract common code into private methods** - Duplicated code in controllers often indicates missing abstractions

### Testing Patterns

- **Understand the testing framework's patterns** - Service specs may use different patterns than controller specs (e.g., class methods vs instance methods)
- **Mock at appropriate boundaries** - Mock external dependencies but be careful about mocking too deeply
- **Test fixtures need to match validations** - When adding validations, ensure test factories are updated accordingly

### Rails Best Practices

- **ActiveStorage validators exist** - Don't write manual file validations when Rails provides cleaner declarative options
- **Database constraints should match business logic** - If a field is truly required, enforce it at the database level
- **Follow existing patterns** - New code should match the style and patterns already established in the codebase

### Development Workflow

- **Run tests frequently during refactoring** - Catch issues early rather than accumulating multiple problems
- **Use linters consistently** - Run rubocop after changes to maintain code quality
- **Read error messages carefully** - Many issues (like Service::Error handling) become clear from stack traces

## File Operation Guidelines

- Always add an empty line at end of files

## Code Review Best Practices

These learnings come from conducting thorough code reviews and quality assessments:

### Review Process

- **Listen to user intent carefully** - When asked to review work, don't assume you need to make edits. Sometimes users want analysis and reporting only.
- **Multi-agent analysis is powerful** - Breaking down complex reviews into specialized agents (code quality, security, testing, business impact) provides comprehensive coverage without overwhelming the user.
- **Test failures matter even if "just setup issues"** - Failing tests, regardless of cause, represent technical debt and reduce confidence in the codebase.

### Implementation Assessment

- **Simple implementations can have complex implications** - A straightforward scope addition can impact reporting, user workflows, support processes, and more.
- **Consider the full ecosystem** - Changes to data visibility affect not just the immediate UI but also analytics, customer service, and user expectations.
- **Documentation gaps compound over time** - When code uses magic values (like status strings), the lack of documentation makes maintenance harder.

### Quality Considerations

- **Consistency is crucial for UX** - Hidden items in lists but accessible directly creates cognitive dissonance for users.
- **Quality assessment should be holistic** - Technical correctness is just one dimension; operational readiness, user impact, and maintainability are equally important.
