//
//  File.swift
//  
//
//  Created by Joe Blau on 1/11/20.
//

import Foundation
import Publish
import Plot

public enum DownloadState: CustomStringConvertible {
    case download
    case preOrder
    
    public var description: String {
        switch self {
        case .download: return "download"
        case .preOrder: return "pre-order"
        }
    }
}

public protocol Sectionable {
    var title: String { get set }
    var subtitle: String { get set }
}

public protocol Steppable {
    var image: String { get set }
    var title: String { get set }
    var description: String { get set }
}

public protocol BulletPointable {
    var symbol: String { get set }
    var title: String { get set }
    var description: String { get set }
    var href: String? { get set }
}

// MARK: - Sections

public protocol WhySectionable: Sectionable {
    var paragraphs: [String] { get set }
}

public protocol HowSectionable: Sectionable {
    var steps: [Steppable] { get set }
}

public protocol TechnologySectionable: Sectionable {
    var features: [BulletPointable] { get set }
}

public protocol FeaturesSectionable: Sectionable {
    var differentiators: [BulletPointable] { get set }
}

public protocol BrandsSectionable: Sectionable {
    var sources: [String] { get set }
}

public protocol DownloadSectionable: Sectionable {
    var appStoreURL: String { get set }
    var state: DownloadState { get set }
}

// MARK: - Theme

public protocol StevenPaulJobsWebsite: Website {
    var title: String { get set }
    var keywords: String { get set }
    var copyright: String { get set }
    var why: WhySectionable { get set }
    var how: HowSectionable { get set }
    var technology: TechnologySectionable { get set }
    var features: FeaturesSectionable { get set }
    var brands: BrandsSectionable { get set }
    var download: DownloadSectionable { get set }
}
