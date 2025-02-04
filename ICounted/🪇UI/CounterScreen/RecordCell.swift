//
//  RecordCell.swift
//  ICounted
//
//  Created by Nebo on 05.12.2024.
//

import SwiftUI

struct RecordCell: View {
    
    let record: CounterRecord
    let color: Color
    let onDelete: ((CounterRecord) -> Void)
    
    var body: some View {
        HStack {
            HStack(alignment: .top) {
                Text(record.date.time())
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.textInfo)
                    .padding([.vertical, .leading], 16)
                
                Text(!record.message.isEmpty ? record.message : Localized.RecordCell.emptyMessage)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.textDark)
                    .padding(.all, 16)
                    .frame(alignment: .top)
            }
            Spacer()
            
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 16)
                .foregroundStyle(color)
                .onTapGesture {
                    onDelete(record)
                }
        }
        .background(color.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(style: .init(lineWidth: 2))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    RecordCell(record: CounterRecord(date: Date(), message: "asds sads jsakdjn nakdn kasdnk jadj na asd sad ", counter: nil), color: .red) { _ in
        
    }
}
