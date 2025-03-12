import 'package:flutter/material.dart';
import 'package:placar_volei/views_models/partida_view_model.dart';
import 'package:placar_volei/views_models/tema_app_view_model.dart';
import 'package:placar_volei/widgets/dados_inherited_notifier_widget.dart';

class ConfiguracaoView extends StatefulWidget {
  const ConfiguracaoView({super.key});

  @override
  State<ConfiguracaoView> createState() => _ConfiguracaoViewState();
}

class _ConfiguracaoViewState extends State<ConfiguracaoView> {
  late final TextEditingController nomeCasaController;
  late final TextEditingController nomeVisitanteController;
  late bool _isLoading;
  @override
  void initState() {
    super.initState();
    nomeCasaController = TextEditingController();
    nomeVisitanteController = TextEditingController();
    _isLoading = false;
  }

  late PartidaViewModel partidaViewModel;
  late TemaAppViewModel themeModeNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    partidaViewModel = DadosInheritedNotifierWidget.of(context);
    themeModeNotifier =
        DadosInheritedNotifierWidget.ofThemeModeNotifier(context);

    nomeCasaController.text = partidaViewModel.timeCasa.nome;
    nomeVisitanteController.text = partidaViewModel.timeVisitante.nome;
  }

  @override
  void dispose() {
    nomeCasaController.dispose();
    nomeVisitanteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
          actions: [
            IconButton(
              onPressed: () async {
                _isLoading = true;
                await partidaViewModel.setNomesTime(
                  nomeCasa: nomeCasaController.text,
                  nomeVisitante: nomeVisitanteController.text,
                );
                _isLoading = false;
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                spacing: 8,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome do Time 1',
                    ),
                    controller: nomeCasaController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome do Time 2',
                    ),
                    controller: nomeVisitanteController,
                  ),
                  ListTile(
                    title: const Text('Tema Escuro'),
                    trailing: AnimatedBuilder(
                      animation: themeModeNotifier,
                      builder: (context, _) => Switch(
                        value: themeModeNotifier.tema == ThemeMode.dark,
                        onChanged: (value) => themeModeNotifier.tema =
                            value ? ThemeMode.dark : ThemeMode.light,
                      ),
                    ),
                  ),
                ],
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      );
}
