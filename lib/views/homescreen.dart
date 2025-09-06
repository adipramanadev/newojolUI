import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:newojol/model/service.dart';
import 'package:newojol/views/layanan.dart';

/// Shell dengan BottomNavigationBar
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = const [
    HomePage(),
    OrdersPage(),
    InboxPage(),
    MarketPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Inbox',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

/// ========================= HOME PAGE (Ala Ojek Online) =========================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _promoCtrl = PageController(viewportFraction: 0.88);
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _promoCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color.fromARGB(255, 255, 102, 0);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            expandedHeight: 210, // dinaikkan supaya lega
            backgroundColor: brandGreen,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: const BoxDecoration(),
                // ⬇️ HAPUS Expanded di sini (penyebab error)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bar atas: lokasi & ikon
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Text(
                            'Antar ke: Jl. Melati Raya No. 204',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Bar pencarian
                    
                    // Kartu saldo
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          _walletPill(
                            icon: Icons.account_balance_wallet,
                            label: 'Saldo',
                            value: 'Rp 125.500',
                          ),
                          const SizedBox(width: 14),
                          Container(
                            width: 1,
                            height: 28,
                            color: Colors.black12,
                          ),
                          const SizedBox(width: 14),
                          _walletPill(
                            icon: Icons.card_giftcard,
                            label: 'Voucher',
                            value: '3',
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 36,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: brandGreen,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                minimumSize: const Size(0, 36),
                              ),
                              onPressed: () {},
                              child: const Text('Top Up'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),

          // Grid layanan utama
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ServicesGrid(),
            ),
          ),

          // Banner promo (carousel)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 160,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView(
                      controller: _promoCtrl,
                      children: const [
                        _PromoCard(
                          image:
                              'https://images.unsplash.com/photo-1556740749-887f6717d7e4?q=80&w=1470&auto=format&fit=crop',
                          title: 'Gratis Ongkir',
                          subtitle: 'Pakai kode: OJEKHEMAT',
                        ),
                        _PromoCard(
                          image:
                              'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=1470&auto=format&fit=crop',
                          title: 'Diskon 60% Makan',
                          subtitle: 'Tanpa minimum belanja',
                        ),
                        _PromoCard(
                          image:
                              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1470&auto=format&fit=crop',
                          title: 'Langganan Hemat',
                          subtitle: 'Benefit ongkir & voucher',
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SmoothPageIndicator(
                        controller: _promoCtrl,
                        count: 3,
                        effect: const WormEffect(dotHeight: 8, dotWidth: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Section: Kategori makanan
          SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Kategori pilihan',
              actionText: 'Jelajahi',
              onTap: () {},
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverGrid.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 120,
              ),
              itemBuilder: (context, i) => _CategoryCard(
                label: const [
                  'Nasi',
                  'Mie',
                  'Minuman',
                  'Cepat Saji',
                  'Seafood',
                  'Cemilan',
                ][i],
                image: const [
                  'https://images.unsplash.com/photo-1567220854476-2b8422873da3?q=80&w=1200&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1604908553985-e9ee4f0f5c02?q=80&w=1200&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1511920170033-f8396924c348?q=80&w=1200&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=1200&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1200&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1542831371-29b0f74f9713?q=80&w=1200&auto=format&fit=crop',
                ][i],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletPill({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black87),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

/// Grid layanan utama (Ride, Food, Send, Mart, Bills, dll)

class _PromoCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const _PromoCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            onError: (_, __) {},
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onTap;
  const _SectionHeader({
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              actionText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MerchantChip extends StatelessWidget {
  final String name;
  final String image;
  final double rating;
  final int eta;
  const _MerchantChip({
    required this.name,
    required this.image,
    required this.rating,
    required this.eta,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16),
                            const SizedBox(width: 4),
                            Text('${rating.toStringAsFixed(1)}'),
                            const SizedBox(width: 8),
                            const Icon(Icons.timer_outlined, size: 16),
                            const SizedBox(width: 4),
                            Text('$eta min'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final String image;
  const _CategoryCard({required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 54,
                width: 54,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 54,
                  width: 54,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

/// ========================= HALAMAN LAIN (placeholder) =========================
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(icon: Icons.receipt_long, title: 'Orders');
  }
}

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(icon: Icons.chat_bubble, title: 'Inbox');
  }
}

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(icon: Icons.storefront, title: 'Market');
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPage(icon: Icons.account_circle, title: 'Account');
  }
}

class _PlaceholderPage extends StatelessWidget {
  final IconData icon;
  final String title;
  const _PlaceholderPage({required this.icon, required this.title});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coming soon...',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
