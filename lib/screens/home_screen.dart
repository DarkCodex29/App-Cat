import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cat_breed.dart';
import '../providers/cat_breeds_provider.dart';
import '../widgets/cat_breed_card.dart';
import '../widgets/skeleton_loader.dart';
import '../widgets/scroll_indicator.dart';
import '../utils/responsive_utils.dart';
import 'cat_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatBreedsProvider>().loadCatBreeds();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CatBreedsProvider>().loadMoreItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Razas de Gatos',
          style: TextStyle(
            fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<CatBreedsProvider>().loadCatBreeds(),
          ),
        ],
      ),
      body: ResponsiveUtils.constrainedContainer(
        context: context,
        child: Consumer<CatBreedsProvider>(
          builder: (context, provider, child) {
            if (provider.showSkeleton) {
              return _buildSkeletonGrid();
            }

            switch (provider.loadingState) {
              case LoadingState.error:
                return _buildErrorState(provider);

              case LoadingState.success:
              case LoadingState.loadingMore:
              case LoadingState.initialLoading:
                return _buildSuccessState(provider);
            }
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid() {
    final columns = ResponsiveUtils.getGridColumns(context);
    final padding = ResponsiveUtils.getHorizontalPadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          childAspectRatio: ResponsiveUtils.getCatCardAspectRatio(context),
          crossAxisSpacing: ResponsiveUtils.getAdaptiveSpacing(context, 12),
          mainAxisSpacing: ResponsiveUtils.getAdaptiveSpacing(context, 12),
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const CatBreedSkeleton(),
      ),
    );
  }

  Widget _buildErrorState(CatBreedsProvider provider) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.getHorizontalPadding(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: ResponsiveUtils.isMobile(context) ? 64 : 80,
              color: Colors.red,
            ),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 16)),
            Text(
              provider.errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 16),
              ),
            ),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 16)),
            ElevatedButton(
              onPressed: () => provider.loadCatBreeds(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                  vertical: ResponsiveUtils.getAdaptiveSpacing(context, 8),
                ),
                child: Text(
                  'Reintentar',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(CatBreedsProvider provider) {
    if (provider.breeds.isEmpty &&
        provider.loadingState == LoadingState.initialLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 16)),
            Text(
              'Cargando razas de gatos...',
              style: TextStyle(
                fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 16),
              ),
            ),
          ],
        ),
      );
    }

    if (provider.breeds.isEmpty) {
      return Center(
        child: Text(
          'No se encontraron razas de gatos',
          style: TextStyle(
            fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 16),
          ),
        ),
      );
    }

    final columns = ResponsiveUtils.getGridColumns(context);
    final padding = ResponsiveUtils.getHorizontalPadding(context);

    return RefreshIndicator(
      onRefresh: () => provider.loadCatBreeds(),
      child: ScrollIndicator(
        scrollController: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                  top: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: ResponsiveUtils.getCatCardAspectRatio(
                      context,
                    ),
                    crossAxisSpacing: ResponsiveUtils.getAdaptiveSpacing(
                      context,
                      12,
                    ),
                    mainAxisSpacing: ResponsiveUtils.getAdaptiveSpacing(
                      context,
                      12,
                    ),
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final breed = provider.breeds[index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 50)),
                      curve: Curves.easeOutCubic,
                      child: CatBreedCard(
                        breed: breed,
                        onTap: () => _navigateToDetail(breed),
                      ),
                    );
                  }, childCount: provider.breeds.length),
                ),
              ),
              if (provider.hasMoreItems)
                SliverToBoxAdapter(child: _buildLoadMoreIndicator(provider)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: ResponsiveUtils.getAdaptiveSpacing(context, 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator(CatBreedsProvider provider) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.getAdaptiveSpacing(context, 16)),
      alignment: Alignment.center,
      child: provider.isLoadingMore
          ? Column(
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  height: ResponsiveUtils.getAdaptiveSpacing(context, 8),
                ),
                Text(
                  'Cargando más razas...',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  void _navigateToDetail(CatBreed breed) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CatDetailScreen(breed: breed),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
