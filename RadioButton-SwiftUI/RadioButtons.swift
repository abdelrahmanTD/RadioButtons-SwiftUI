//
//  RadioButtons.swift
//  RadioButton-SwiftUI
//
//  Created on Saturday, July 29, 2023
//  Created by Abdelrahman Abo Al Nasr
//

import SwiftUI

/// A view that display a group of radio buttons.
///
/// A radio buttons group view presents a group of options for selecting a
/// single option from multiple options. It requires its options to conform to
/// `Hashable` and `CustomStringConvertible` protocols.
///
/// The conformance to `Hashable` is necessary to uniquely identify each option,
/// while conformance to `CustomStringConvertible` enables displaying the
/// options’s description as a label.
///
/// ### Usage Example
///
/// ```swift
/// let colors = ["Red", "Green", "Blue"]
/// @State private var selectedColor: String = ""
///
/// var body: some View {
///     VStack(alignment: .leading) {
///         Text("Select your favorite color:")
///
///         RadioButtons(options: colors, selectedOption: $selectedColor)
///             .optionForegroundColor(.black)
///             .selectedOptionForegroundColor(.blue)
///     }
/// }
/// ```
public struct RadioButtons<Option>: View where Option: Hashable & CustomStringConvertible {
    /// The layout orientation of the radio buttons.
    private let orientation: LayoutOrientation

    /// An array of options to be displayed as radio buttons.
    private let options: [Option]

    /// A binding to the currently selected radio button.
    @Binding private var selectedOption: Option

    // MARK: - Modifier Variables

    /// The foreground color of the radio buttons when not selected.
    @State private var optionForegroundColor: Color?

    /// The foreground color of the selected radio button.
    @State private var selectedOptionForegroundColor: Color?

    // MARK: - Initialization

    /// Creates a radio buttons view with the provided options.
    ///
    /// - Parameters:
    ///     - orientation: The layout orientation of the radio buttons. It can
    ///     be either `.horizontal` or `.vertical` layout. Default is vertically
    ///     layout.
    ///
    ///     - options: Array of options to be displayed as radio buttons.
    ///
    ///     - selectedOptions: Binding to the currently selected option. This
    ///     value will be updated when the user selects a differ option.
    public init(
        orientation: LayoutOrientation = .vertical,
        options: [Option],
        selectedOption: Binding<Option>
    ) {
        self.orientation = orientation
        self.options = options
        self._selectedOption = selectedOption
    }

    // MARK: - Body

    /// The content and behavior of the view.
    public var body: some View {
        let layout = orientation == .vertical
        ? AnyLayout(VStackLayout(alignment: .leading))
        : AnyLayout(HStackLayout())

        layout {
            ForEach(options, id: \.self) { option in
                Button {
                    self.selectedOption = option
                } label: {
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(optionForegroundColor)
                                .frame(width: 20, height: 20)

                            if selectedOption == option {
                                Circle()
                                    .foregroundColor(selectedOptionForegroundColor)
                                    .frame(width: 15, height: 15)
                            }
                        }

                        Text(String(describing: option))
                    }
                }
            }
        }
    }
}

// MARK: - Previews

struct RadioButtons_Previews: PreviewProvider {
    struct MockRadioButtons: View {
        let data1 = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        @State private var selectedOption1: String = ""

        let data2 = [1, 2, 3, 4, 5]
        @State private var selectedOption2: Int = 0

        var body: some View {
            VStack(spacing: 20) {
                RadioButtons(options: data1, selectedOption: $selectedOption1)
                    .optionForegroundColor(.brown)
                    .selectedOptionForegroundColor(.cyan)
                    .foregroundColor(.black)

                RadioButtons(orientation: .horizontal, options: data2, selectedOption: $selectedOption2)
            }
        }
    }

    static var previews: some View {
        MockRadioButtons()
    }
}

// MARK: - Radio Buttons Layout

extension RadioButtons {
    /// A representation for available layout orientation of the radio buttons
    /// group.
    public enum LayoutOrientation {
        /// Laying out radio buttons horizontally.
        case horizontal

        /// Laying out radio buttons vertically.
        case vertical
    }
}

// MARK: - View's ViewModifiers

extension RadioButtons {
    /// Sets the foreground color of the radio buttons.
    ///
    /// - Parameter color: The radio button foreground color to use when
    /// displaying this view. Pass `nil` to remove any custom foreground color.
    /// If a container doesn’t specify any color, the system uses the default
    /// color for `Button`.
    ///
    /// - Returns: A modified `RadioButtons` with the specified foreground
    /// color for radio buttons.
    ///
    /// - Important:
    public func optionForegroundColor(_ color: Color?) -> RadioButtons {
        var view = self
        view._optionForegroundColor = State(initialValue: color)
        return view
    }

    /// Sets the foreground color of the selected radio button.
    ///
    /// - Parameter color: The selected radio button foreground color to use
    /// when displaying this view. Pass `nil` to remove any custom foreground
    /// color. If a container doesn’t specify any color, the system uses the
    /// default color for `Button`.
    ///
    /// - Returns: A modified `RadioButtons` with the specified foreground
    /// color for the selected radio buttons.
    public func selectedOptionForegroundColor(_ color: Color?) -> RadioButtons {
        var view = self
        view._selectedOptionForegroundColor = State(initialValue: color)
        return view
    }
}
