import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import './app_switch.dart';
import './app_text_field.dart';
import 'app_button.dart';
import 'app_single_select.dart';

class Categorie {
  const Categorie({required this.id, required this.nom});

  final String id;
  final String nom;
}

class UiKitSamplesPage extends StatefulWidget {
  const UiKitSamplesPage({super.key});

  @override
  State<UiKitSamplesPage> createState() => _UiKitSamplesPageState();
}

class _UiKitSamplesPageState extends State<UiKitSamplesPage> {
  static const List<String> _villes = [
    'Dakar',
    'Thiès',
    'Saint-Louis',
    'Ziguinchor',
    'Touba',
    'Mbour',
  ];

  static const List<Categorie> _categories = [
    Categorie(id: '1', nom: 'Location de véhicules'),
    Categorie(id: '2', nom: 'Développement mobile'),
    Categorie(id: '3', nom: 'Développement web'),
    Categorie(id: '4', nom: 'Formation'),
    Categorie(id: '5', nom: 'Conseil technique'),
  ];

  // --- États locaux ---------------------------------------------------------

  bool _isLoading = false;
  bool _notificationsEnabled = true;
  bool _sombreEnabled = false;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _villeSelectionnee;
  List<String> _villesSelectionnees = [];
  List<Categorie> _categoriesSelectionnees = [];

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _simulerChargement() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle('Boutons'),
        _buildButtonsSection(),
        const SizedBox(height: AppSizes.xl),

        _buildSectionTitle('Champs texte'),
        _buildTextFieldsSection(),
        const SizedBox(height: AppSizes.xl),

        _buildSectionTitle('Switch'),
        _buildSwitchSection(),
        const SizedBox(height: AppSizes.xl),

        _buildSectionTitle('Sélection unique'),
        _buildSingleSelectSection(),
        const SizedBox(height: AppSizes.xl),

        _buildSectionTitle('Sélection multiple'),
        _buildMultiSelectSection(),
        const SizedBox(height: AppSizes.xl),
      ],
    );
  }

  // --- Sections --------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.fontSizeXl,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Variants, taille medium par défaut ---
        Wrap(
          spacing: AppSizes.sm,
          runSpacing: AppSizes.sm,
          children: [
            AppButton(
              label: 'Primary',
              variant: ButtonVariant.primary,
              onPressed: () {},
            ),
            AppButton(
              label: 'Secondary',
              variant: ButtonVariant.secondary,
              onPressed: () {},
            ),
            AppButton(
              label: 'Outline primary',
              variant: ButtonVariant.outlinePrimary,
              onPressed: () {},
            ),
            AppButton(
              label: 'Outline secondary',
              variant: ButtonVariant.outlineSecondary,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSizes.md),

        // --- Tailles ---
        Wrap(
          spacing: AppSizes.sm,
          runSpacing: AppSizes.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AppButton(label: 'Small', size: ButtonSize.small, onPressed: () {}),
            AppButton(label: 'Medium', size: ButtonSize.medium, onPressed: () {}),
            AppButton(label: 'Large', size: ButtonSize.large, onPressed: () {}),
          ],
        ),
        const SizedBox(height: AppSizes.md),

        // --- Avec icône ---
        AppButton(
          label: 'Ajouter un véhicule',
          icon: Icons.add,
          onPressed: () {},
        ),
        const SizedBox(height: AppSizes.md),

        // --- Pleine largeur + état loading ---
        AppButton(
          label: 'Envoyer la demande',
          isFullWidth: true,
          isLoading: _isLoading,
          onPressed: _simulerChargement,
        ),
        const SizedBox(height: AppSizes.md),

        // --- Désactivé ---
        const AppButton(
          label: 'Bouton désactivé',
          onPressed: null,
        ),
      ],
    );
  }

  Widget _buildTextFieldsSection() {
    return Column(
      children: [
        AppTextField(
          controller: _nomController,
          label: 'Nom complet',
          hint: 'Ex : Ndiaga Diop',
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: AppSizes.md),
        AppTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'exemple@saware.tech',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Champ requis';
            if (!value.contains('@')) return 'Email invalide';
            return null;
          },
        ),
        const SizedBox(height: AppSizes.md),
        const AppTextField(
          label: 'Mot de passe',
          obscureText: true,
          prefixIcon: Icons.lock_outline,
        ),
        const SizedBox(height: AppSizes.md),
        const AppTextField(
          label: 'Champ en erreur',
          errorText: 'Ce champ est obligatoire',
        ),
        const SizedBox(height: AppSizes.md),
        const AppTextField(
          label: 'Champ désactivé',
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildSwitchSection() {
    return Column(
      children: [
        AppSwitch(
          label: 'Notifications',
          subtitle: 'Recevoir les alertes de réservation par email',
          value: _notificationsEnabled,
          onChanged: (value) => setState(() => _notificationsEnabled = value),
        ),
        const Divider(color: AppColors.border),
        AppSwitch(
          label: 'Mode sombre',
          value: _sombreEnabled,
          onChanged: (value) => setState(() => _sombreEnabled = value),
        ),
        const Divider(color: AppColors.border),
        const AppSwitch(
          label: 'Option désactivée',
          value: false,
          onChanged: null,
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildSingleSelectSection() {
    return AppSingleSelect<String>(
      label: 'Ville de résidence',
      hint: 'Choisir une ville',
      items: _villes,
      labelBuilder: (ville) => ville,
      selectedItem: _villeSelectionnee,
      onChanged: (ville) => setState(() => _villeSelectionnee = ville),
    );
  }

  Widget _buildMultiSelectSection() {
    return Column(
      children: [
        // --- Multi select sur une liste de villes (String) ---
        AppMultiSelect<String>(
          label: 'Villes desservies',
          hint: 'Choisir une ou plusieurs villes',
          items: _villes,
          labelBuilder: (ville) => ville,
          selectedItems: _villesSelectionnees,
          onChanged: (villes) => setState(() => _villesSelectionnees = villes),
        ),
        const SizedBox(height: AppSizes.md),

        // --- Multi select sur une liste de catégories (objet métier) ---
        AppMultiSelect<Categorie>(
          label: 'Catégories de services',
          hint: 'Choisir une ou plusieurs catégories',
          items: _categories,
          labelBuilder: (categorie) => categorie.nom,
          selectedItems: _categoriesSelectionnees,
          onChanged: (categories) => setState(() => _categoriesSelectionnees = categories),
        ),
      ],
    );
  }
}
