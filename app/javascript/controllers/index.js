// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import { Alert, Autosave, ColorPreview, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"

eagerLoadControllersFrom("controllers", application)
// application.register('alert', Alert)
// application.register('autosave', Autosave)
// application.register('color-preview', ColorPreview)
// application.register('dropdown', Dropdown)
// application.register('modal', Modal)
// application.register('popover', Popover)
// application.register('slideover', Slideover)
// application.register('tabs', Tabs)
application.register('toggle', Toggle)
