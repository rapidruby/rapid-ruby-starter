module StylesHelper
  def page_title(title)
    tag.h1 title, class: page_title_classes.render
  end

  def page_title_classes
    ClassVariants.build(
      base: "font-bold tracking-tight text-gray-800",
      variants: {
        style: {
          md: "text-3xl",
        },
        align: {
          left: "text-left",
          center: "text-center",
        }
      },
      defaults: {
        style: :md,
        align: :left
      }
    )
  end

  def button_classes
    ClassVariants.build(
      base: "py-2 px-4 rounded-md md:text-sm font-semibold inline-flex items-center cursor-pointer",
      variants: {
        style: {
          secondary: "bg-white text-gray-600 border border-gray-200 hover:border-gray-500",
          primary: "bg-slate-800 hover:bg-opacity-90 text-white"
        },
        fullwidth: "w-full justify-center",
        nowrap: "whitespace-nowrap"
      },
      defaults: {
        style: :primary
      }
    )
  end

  def label_classes
    ClassVariants.build(base: "block text-sm font-medium text-gray-700")
  end

  def input_classes
    ClassVariants.build(base: "appearance-none block w-full px-3 py-2 border-2 border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:ring-blue-200 focus:border-blue-200 sm:text-sm")
  end

  def hint_classes
    ClassVariants.build(base: "mt-2 text-sm text-gray-500")
  end
end
