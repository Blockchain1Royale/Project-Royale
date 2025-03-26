import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Project Royale',
  description: 'Next-generation Battle Royale with Blockchain Integration',
  base: '/Project-Royale/',
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Whitepaper', link: '/whitepaper/overview' },
      { text: 'Roadmap', link: '/roadmap/phases' }
    ],
    sidebar: [
      {
        text: 'Whitepaper',
        items: [
          { text: 'Overview', link: '/whitepaper/overview' },
          { text: 'Vision & Mission', link: '/whitepaper/vision' },
          { text: 'Technology Stack', link: '/whitepaper/technology' },
          { text: 'Tokenomics', link: '/whitepaper/tokenomics' }
        ]
      },
      {
        text: 'Roadmap',
        items: [
          { text: 'Development Phases', link: '/roadmap/phases' },
          { text: 'Milestones', link: '/roadmap/milestones' }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/Blockchain1Royale/Project-Royale' }
    ]
  }
}) 