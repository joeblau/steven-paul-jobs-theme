//
//  File.swift
//  
//
//  Created by Joe Blau on 1/8/20.
//

import Publish
import Plot

public enum PublishError: Error {
    case castSiteError
    case notImplemented
}

public extension Theme where Site: StevenPaulJobsThemable {
    static var stevenPaulJobs: Self {
         Theme(htmlFactory: StevenPaulJobsHTMLFactory())
    }
    
    private struct StevenPaulJobsHTMLFactory: HTMLFactory {
     func makeIndexHTML(for index: Index,
                            context: PublishingContext<Site>) throws -> HTML {
             return HTML(
                 .lang(context.site.language),
                 .head(for: index,
                       on: context.site,
                       titleSeparator: " | ",
                       stylesheetPaths: buildStyleSheettPaths(for: context.site),
                       rssFeedPath: .defaultForRSSFeed,
                       rssFeedTitle: nil),
                 .body(
                     .hero(for: context.site),
                     .header(for: context.site),
                     .main(
                         .why(for: context.site),
                         .how(for: context.site),
                         .product(for: context.site),
                         .features(for: context.site),
                         .brands(for: context.site),
                         .community(for: context.site),
                         .download(for: context.site)
                     ),
                     .footer(for: context.site)
                 )
             )
         }
         
         func makeSectionHTML(for section: Section<Site>,
                              context: PublishingContext<Site>) throws -> HTML {
             return HTML()
         }
         
         func makeItemHTML(for item: Item<Site>,
                           context: PublishingContext<Site>) throws -> HTML {
             return HTML()
         }
         
         func makePageHTML(for page: Page,
                           context: PublishingContext<Site>) throws -> HTML {
         return HTML(
                 .lang(context.site.language),
                 .head(for: page,
                       on: context.site,
                       titleSeparator: " | ",
                       stylesheetPaths: buildStyleSheettPaths(for: context.site),
                       rssFeedPath: .defaultForRSSFeed,
                       rssFeedTitle: nil),
                 .body(
                     
                     .header(
                         .h1(.text(page.title)),
                         .h3(.text(page.description))
                         ),
                     .main(
                         .section(
                             .class("max-section"),
                             page.body.node
                         )
                     ),
                     .footer(for: context.site)
                 )
             )
         }
         
         func makeTagListHTML(for page: TagListPage,
                              context: PublishingContext<Site>) throws -> HTML? {
             return HTML()
         }
         
         func makeTagDetailsHTML(for page: TagDetailsPage,
                                 context: PublishingContext<Site>) throws -> HTML? {
             return HTML()
         }
        
        func buildStyleSheettPaths<T: StevenPaulJobsThemable>(for site: T) -> [Path] {
            var templateStyleSheets = [
                Path("/StevenPaulJobsTheme/css/styles.css"),
                Path("/StevenPaulJobsTheme/fonts/stylesheet.css")]
            if let css = site.css {
                templateStyleSheets.append(Path(css))
            }
            return templateStyleSheets
        }
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    // MARK: Hero
    
    static func hero<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let hero = site.hero else {
            return .empty
        }
        return section(
            .class("hero hero-background"),
            .h1(.text(hero.title)),
            .appStoreLink(for: site),
            .div(
                .element(named: "picture", nodes: [
                    .selfClosedElement(named: "source", attributes: [
                        .attribute(named: "class", value: "hero-image"),
                        .attribute(named: "src", value: "/img/dark/nytimes-hero.png"),
                        .attribute(named: "srcset", value: "/img/dark/nytimes-hero@2x.png 2x"),
                        .attribute(named: "media", value: "(prefers-color-scheme: dark)")
                    ]),
                    .selfClosedElement(named: "img", attributes: [
                        .attribute(named: "class", value: "hero-image"),
                        .attribute(named: "src", value: "/img/light/nytimes-hero.png"),
                        .attribute(named: "srcset", value: "/img/light/nytimes-hero@2x.png 2x")
                    ])
                ])
                
            )
        )
    }
    
    // MARK: Header
    
    static func header<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let header = site.header else {
            return .empty
        }
        return .section(
            .header(
                .h1(.text(header.title)),
                .if(header.subtitle.isEmpty == false,
                    .h3(.text(header.subtitle))
                )
            )
        )
    }
    
    // MARK: Why
    
    static func why<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let why = site.why else {
            return .empty
        }
        return .section(
            .class("why"),
            .header(
                .h4(.text(why.title))
            ),
            .div(
                .class("max-section"),
                .forEach(why.paragraphs) { paragraph in
                    .p(.text(paragraph))
                }
            )
        )
    }
    
    // MARK: How
    
    static func how<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let how = site.how else {
            return .empty
        }
        return .element(named: "", nodes: [
            .header(
                .h2(.text(how.title)),
                .if(how.subtitle.isEmpty == false,
                    .h4(.text(how.subtitle))
                )
            ),
            .section(
                .class("how max-section"),
                .forEach(how.steps) { step in
                    .div(
                        .class("well"),
                        .img(
                            .class("how-image"),
                            .src("/img/\(step.image).svg")
                        ),
                        .h4(
                            .text(step.title),
                            .br(),
                            .element(named: "small", nodes: [.text(step.description)])
                        )
                    )
                }
            )
        ])
    }
    
    // MARK: Product
    
    static func product<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let product = site.product else {
            return .empty
        }
        return .element(named: "", nodes: [
            .header(
                .h2(.text(product.title)),
                .if(product.subtitle.isEmpty == false,
                    .h4(.text(product.subtitle))
                )
            ),
            .section(
                .class("product"),
                .forEach(product.features) { feature in
                    .div(
                        .class("well"),
                        .if(feature.images != nil,
                            .forEach(feature.images!, { image in
                                .element(named: "picture", nodes: [
                                        .selfClosedElement(named: "source", attributes: [
                                            .attribute(named: "src", value: "/img/\(image).png"),
                                            .attribute(named: "srcset", value: "/img/\(image)@2x.png 2x"),
                                            .attribute(named: "media", value: "(prefers-color-scheme: dark)")
                                        ]),
                                        .selfClosedElement(named: "img", attributes: [
                                            .attribute(named: "src", value: "/img/\(image).png"),
                                            .attribute(named: "srcset", value: "/img/\(image)@2x.png 2x")
                                        ])
                                    ])
                            })
                        ),
                        .p(
                            .strong(
                                .class("system-red"),
                                .text(feature.title)
                            ),
                            .text(" \(feature.description)")
                        ),
                        .if(feature.tags != nil,
                            .p(
                                .forEach(feature.tags!, { tag in
                                    .element(named: "mark", nodes: [
                                        .class("span-red"),
                                        .text(tag)
                                    ])
                                })
                            )
                        ),
                        .if(feature.href != nil,
                            .a(
                                .href(feature.href!),
                                .text("Learn More "),
                                .span(.class("icon"), .text("􀄯"))
                            )
                        )
                    )
                }
            )
        ])
    }
    
    // MARK: Features
    
    static func features<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let features = site.features else {
            return .empty
        }
        return .element(named: "", nodes: [
            .header(
                .h2(.text(features.title)),
                .if(features.subtitle.isEmpty == false,
                    .h4(.text(features.subtitle))
                )
            ),
            .section(
                .class("features max-section"),
                .forEach(features.differentiators) { differentiator in
                    .div(
                        .h3(
                            .if(differentiator.symbol != nil,
                                .span(.class("icon"), .text(differentiator.symbol!))
                            ),
                            .br(),
                            .element(named: "small", text: differentiator.title)
                        ),
                        .p(.text(differentiator.description)),
                        .if(differentiator.href != nil,
                            .a(
                                .href(differentiator.href ?? ""),
                                .text("Learn More "),
                                .span(.class("icon"), .text("􀄯"))
                            )
                        )
                    )
                }
            )
        ])
    }
    
    // MARK: Brands
    
    static func brands<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let brands = site.brands else {
            return .empty
        }
        return .element(named: "", nodes: [
            .header(
                .h2(.text(brands.title)),
                .if(brands.subtitle.isEmpty == false,
                    .h4(.text(brands.subtitle))
                )
            ),
            .section(
                .class("brands"),
                .forEach(brands.sources) { source in
                    .div(
                        .element(named: "picture", nodes: [
                            .selfClosedElement(named: "source", attributes: [
                                .attribute(named: "class", value: "brand-image"),
                                .attribute(named: "src", value: "/img/dark/source/\(source).png"),
                                .attribute(named: "srcset", value: "/img/dark/source/\(source)@2x.png 2x"),
                                .attribute(named: "media", value: "(prefers-color-scheme: dark)")
                            ]),
                            .selfClosedElement(named: "img", attributes: [
                                .attribute(named: "class", value: "brand-image"),
                                .attribute(named: "src", value: "/img/light/source/\(source).png"),
                                .attribute(named: "srcset", value: "/img/light/source/\(source)@2x.png 2x")
                            ])
                        ])

                    )
                }
            )
        ])
    }
    
    // MARK: Community
    
    static func community<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let community = site.community else {
            return .empty
        }
        return .element(named: "", nodes: [
            .header(
                .h2(.text(community.title)),
                .if(community.subtitle.isEmpty == false,
                    .h4(.text(community.subtitle))
                )
            ),
            .section(
                .class("community-background"),
                .forEach(community.resources) { resource in
                    .div(
                        .p(
                            .a(
                                .href(resource.href),
                                .text(resource.title)
                            ),
                            .text(" — \(resource.description)")
                        )
                    )
                }
            )
        ])
    }
    
    // MARK: Download
    
    static func download<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let download = site.download else {
            return .empty
        }
        return .element(named: "", nodes: [
            .header(
                .h2(.text(download.title)),
                .if(download.subtitle.isEmpty == false,
                    .h4(.text(download.subtitle))
                )
            ),
            .section(
                .class("downloads"),
                .div(
                    .appStoreLink(for: site)
                )
            )
        ])
    }
    
    // MARK: Footer

    static func footer<T: StevenPaulJobsThemable>(for site: T) -> Node {
        return .footer(
            .a(.href("/"), .text("Home")),
            .text(" • "),
            .a(.href("https://twitter.com/getshields"), .text("Twitter")),
            .text(" • "),
            .a(.href("https://instagram.com/getshields"), .text("Instagram")),
            .text(" • "),
            .a(.href("https://github.com/getshields"), .text("GitHub")),
            .if(site.hasPrivacyURL,
                .element(named: "", nodes: [
                    .text(" • "),
                    .a(.href("/privacy"), .text("Privacy"))
                ])
            ),
            .br(),
            .element(named: "small", text: site.copyright)
        )
    }
    
    //MARK: - Utility functions
    
    static func appStoreLink<T: StevenPaulJobsThemable>(for site: T) -> Node {
        guard let download = site.download else {
            return .empty
        }
        return .a(
            .href(download.appStoreURL),
            .element(named: "picture", nodes: [
                .class("download-image"),
                .selfClosedElement(named: "source", attributes: [
                    .attribute(named: "srcset", value: "/StevenPaulJobsTheme/img/\(download.state.description)-mac-app-store/us-uk/white.svg"),
                    .attribute(named: "media", value: "(prefers-color-scheme: dark)")
                ]),
                .selfClosedElement(named: "img", attributes: [
                    .attribute(named: "src", value: "/StevenPaulJobsTheme/img/\(download.state.description)-mac-app-store/us-uk/black.svg"),
                ])
            ])
        )
    }
}
