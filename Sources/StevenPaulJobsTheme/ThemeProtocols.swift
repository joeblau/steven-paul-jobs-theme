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
    var symbol: String? { get set }
    var tags: [String] { get set }
    var images: [String] { get set }
    var title: String { get set }
    var description: String { get set }
    var href: String { get set }
}

public protocol CommunityResourcable {
    var title: String { get set }
    var description: String { get set }
    var href: String { get set }
}
// MARK: - Sections

public protocol HeroSectionable: Sectionable {}

public protocol HeaderSectionable: Sectionable {}

public protocol WhySectionable: Sectionable {
    var paragraphs: [String] { get set }
}

public protocol HowSectionable: Sectionable {
    var steps: [Steppable] { get set }
}

public protocol ProductSectionable: Sectionable {
    var features: [BulletPointable] { get set }
}

public protocol FeaturesSectionable: Sectionable {
    var differentiators: [BulletPointable] { get set }
}

public protocol BrandsSectionable: Sectionable {
    var sources: [String] { get set }
}

public protocol CommunitySectionable: Sectionable {
    var resources: [CommunityResourcable] { get set }
}
public protocol DownloadSectionable: Sectionable {
    var appStoreURL: String { get set }
    var state: DownloadState { get set }
}

// MARK: - Theme

public protocol StevenPaulJobsThemable: Website {
    var css: String? { get set }
    var keywords: String { get set }
    var copyright: String { get set }
    var hasPrivacyURL: Bool { get set }
    var hero: HeroSectionable? { get set }
    var header: HeaderSectionable? { get set }
    var why: WhySectionable? { get set }
    var how: HowSectionable? { get set }
    var product: ProductSectionable? { get set }
    var features: FeaturesSectionable? { get set }
    var brands: BrandsSectionable? { get set }
    var community: CommunitySectionable? { get set }
    var download: DownloadSectionable? { get set }
}
