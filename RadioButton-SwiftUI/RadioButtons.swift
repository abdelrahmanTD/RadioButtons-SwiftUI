//
//  RadioButtons.swift
//  RadioButton-SwiftUI
//
//  Created on Saturday, July 29, 2023
//  Created by Abdelrahman Abo Al Nasr
//

import SwiftUI

public struct RadioButtons<Option>: View where Option: Hashable & CustomStringConvertible {
    private let orientation: LayoutOrientation

    private let options: [Option]

    @Binding private var selectedOption: Option

    // MARK: - Modifier Variables

    @State private var optionForegroundColor: Color?

    @State private var selectedOptionForegroundColor: Color?

    // MARK: - Initialization

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

struct RadioButtonsGroup_Previews: PreviewProvider {
    struct MockRadioButtonsGroup: View {
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
        MockRadioButtonsGroup()
    }
}

// MARK: - Radio Buttons Layout

extension RadioButtons {
    public enum LayoutOrientation {
        case horizontal

        case vertical
    }
}

// MARK: - View's ViewModifiers

extension RadioButtons {
    public func optionForegroundColor(_ color: Color?) -> RadioButtons {
        var view = self
        view._optionForegroundColor = State(initialValue: color)
        return view
    }

    public func selectedOptionForegroundColor(_ color: Color?) -> RadioButtons {
        var view = self
        view._selectedOptionForegroundColor = State(initialValue: color)
        return view
    }
}
