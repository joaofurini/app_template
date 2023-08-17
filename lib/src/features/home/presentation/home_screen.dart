import 'package:adaptive_components/adaptive_components.dart';
import 'package:app_template/src/features/home/domain/model/propostas_model.dart';
import 'package:app_template/src/features/home/domain/usecases/getUsers.dart';
import 'package:app_template/src/features/home/presentation/home_store.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/extensions.dart';

import '../../../shared/views/views.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeStore homeStore = Modular.get<HomeStore>();

  List<Post>? posts;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // homeStore.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.isMobile) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: const Text('Home'),
                actions: const [BrightnessToggle()],
                bottom: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Propostas'),
                    Tab(text: 'Oportunidades'),
                  ],
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) => TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Observer(
                        builder: (context) {
                          return Column(
                            children: [
                              ElevatedButton(
                                child: Text('Testar Arquitetura'),
                                onPressed: () async {
                                  await homeStore.getPosts();
                                },
                              ),
                              Visibility(
                                replacement: CircularProgressIndicator(),
                                visible: !homeStore.loading,
                                child: SizedBox(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Text('${homeStore.posts?[0]?.title}')
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: AdaptiveColumn(
              children: [
                AdaptiveContainer(
                  columnSpan: 12,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Good morning',
                            style: context.displaySmall,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const BrightnessToggle(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
