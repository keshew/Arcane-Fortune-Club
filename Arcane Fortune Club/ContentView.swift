import SwiftUI

struct ContentView: View {
    @State private var hasOnboarded = false

    var body: some View {
        ZStack {
            AppPalette.deepObsidian.ignoresSafeArea()
            if hasOnboarded {
                MainTabView()
            } else {
                OnboardingFlow {
                    hasOnboarded = true
                }
            }
        }
    }
}

private struct MainTabView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }
            GamesView()
                .tabItem {
                    Label("Games", systemImage: "sparkles.rectangle.stack")
                }
            ArtifactsView()
                .tabItem {
                    Label("Artifacts", systemImage: "diamond")
                }
            MissionsView()
                .tabItem {
                    Label("Missions", systemImage: "point.3.filled.connected.trianglepath.dotted")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .tint(AppPalette.icyBlue)
        .preferredColorScheme(.dark)
    }
}

private struct OnboardingFlow: View {
    @State private var page = 0
    let onFinish: () -> Void

    var body: some View {
        ZStack {
            AppGradientBackground()
            TabView(selection: $page) {
                OnboardingCard(
                    title: "Enter Arcane Fortune Club",
                    subtitle: "Train focus, memory, speed, and precision through short private challenges.",
                    bullets: [
                        "Skill-only games",
                        "No betting mechanics",
                        "Private progression",
                        "Daily mental rituals"
                    ],
                    buttonTitle: "Begin",
                    symbol: "diamond.fill",
                    action: { page = 1 }
                )
                .tag(0)

                OnboardingCard(
                    title: "Play. Improve. Unlock.",
                    subtitle: "Complete short challenges, earn Mind Points, raise your Prestige, and unlock rare Artifacts.",
                    bullets: [
                        "Choose a challenge",
                        "Complete a focus test",
                        "Earn points and progress"
                    ],
                    buttonTitle: "Continue",
                    symbol: "atom",
                    action: { page = 2 }
                )
                .tag(1)

                RankStartCard {
                    onFinish()
                }
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        }
    }
}

private struct OnboardingCard: View {
    let title: String
    let subtitle: String
    let bullets: [String]
    let buttonTitle: String
    let symbol: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 22) {
            Spacer(minLength: 30)

            ClubSymbolView(systemName: symbol)
                .padding(.bottom, 8)

            VStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 33, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppPalette.silverText)

                Text(subtitle)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppPalette.mutedSteel)
            }

            VStack(spacing: 10) {
                ForEach(bullets, id: \.self) { bullet in
                    HStack(spacing: 10) {
                        Circle()
                            .fill(AppPalette.icyBlue.opacity(0.8))
                            .frame(width: 7, height: 7)
                        Text(bullet)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText.opacity(0.95))
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                }
            }
            .padding(.vertical, 14)
            .glassPanel()

            Spacer()

            PrimaryButton(title: buttonTitle, action: action)
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
        }
        .padding(.horizontal, 20)
    }
}

private struct RankStartCard: View {
    let action: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 40)

            Text("Start as an Initiate")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)

            Text("Every member begins with zero Prestige. Complete your first session to unlock your path.")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(AppPalette.mutedSteel)

            VStack(spacing: 14) {
                HStack {
                    Text("Current Rank")
                        .foregroundStyle(AppPalette.mutedSteel)
                    Spacer()
                    Text("Visitor")
                        .foregroundStyle(AppPalette.silverText)
                }
                HStack {
                    Text("Next Rank")
                        .foregroundStyle(AppPalette.mutedSteel)
                    Spacer()
                    Text("Initiate")
                        .foregroundStyle(AppPalette.icyBlue)
                }
            }
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .padding(18)
            .glassPanel()

            Spacer()

            PrimaryButton(title: "Enter Arcane Fortune Club", action: action)
                .padding(.horizontal, 12)
                .padding(.bottom, 14)
        }
        .padding(.horizontal, 20)
    }
}

private struct TodayView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 14) {
                    topBar
                    dailyRitualCard
                    quickStats
                    featuredTrial
                    notesBlock
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 24)
            }
            .background(AppGradientBackground())
            .navigationBarHidden(true)
        }
    }

    private var topBar: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Arcane Fortune Club")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(AppPalette.silverText)
                Text("Today's mental ritual")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.mutedSteel)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("12 800")
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundStyle(AppPalette.icyBlue)
                Text("Mind Points")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.silverText.opacity(0.85))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .glassPanel(cornerRadius: 16)
        }
    }

    private var dailyRitualCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Daily Ritual")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(AppPalette.silverText)
                Spacer()
                Text("+1 200 Mind Points")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppPalette.softViolet)
            }

            Text("Complete 3 different trials to finish today's ritual.")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)

            HStack(spacing: 14) {
                CircleProgressView(progress: 0.33, text: "1 / 3")
                VStack(alignment: .leading, spacing: 8) {
                    MiniSkillIndicator(name: "Memory", complete: true)
                    MiniSkillIndicator(name: "Reflex", complete: false)
                    MiniSkillIndicator(name: "Precision", complete: false)
                }
                Spacer(minLength: 0)
            }
            .padding(.top, 2)

            CompactButton(title: "Continue Ritual")
        }
        .padding(16)
        .glassPanel(cornerRadius: 22)
    }

    private var quickStats: some View {
        VStack(spacing: 10) {
            TinyStatCard(title: "Rank", value: "Visitor", symbol: "diamond")
            TinyStatCard(title: "Streak", value: "1 Day", symbol: "waveform.path.ecg")
            TinyStatCard(title: "Focus State", value: "Calm", symbol: "eye")
        }
    }

    private var featuredTrial: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Featured Trial")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Mirror Sequence")
                        .font(.system(size: 19, weight: .bold, design: .rounded))
                        .foregroundStyle(AppPalette.silverText)
                    Spacer()
                    Text("Memory Event")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundStyle(AppPalette.icyBlue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(AppPalette.icyBlue.opacity(0.12), in: Capsule())
                }
                Text("Repeat a shifting pattern before it fades.")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.mutedSteel)

                VStack(alignment: .leading, spacing: 8) {
                    Text("+900 Mind Points")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppPalette.softViolet)
                    CompactButton(title: "Start Trial", horizontalPadding: 14, verticalPadding: 8)
                }
            }
            .padding(14)
            .glassPanel(cornerRadius: 18)
        }
    }

    private var notesBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Club Notes")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)

            LazyVStack(spacing: 8) {
                NoteCard(text: "New artifact available")
                NoteCard(text: "Weekly mission unlocked")
                NoteCard(text: "Precision trials give bonus today")
            }
        }
    }
}

private struct GamesView: View {
    @State private var selectedCategory = "All"

    private let categories = ["All", "Memory", "Reflex", "Logic", "Precision", "Calm"]

    var filteredTrials: [Trial] {
        if selectedCategory == "All" {
            return Trial.samples
        }
        return Trial.samples.filter { $0.tags.joined(separator: " ").localizedCaseInsensitiveContains(selectedCategory) }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Trials")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        Text("Choose your focus challenge")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(AppPalette.mutedSteel)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { category in
                                Button {
                                    selectedCategory = category
                                } label: {
                                    Text(category)
                                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                                        .foregroundStyle(selectedCategory == category ? AppPalette.deepObsidian : AppPalette.silverText)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(selectedCategory == category ? AppPalette.icyBlue : AppPalette.graphiteCard)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    todaySetCard

                    LazyVStack(spacing: 10) {
                        ForEach(filteredTrials) { trial in
                            NavigationLink {
                                TrialDetailView(trial: trial)
                            } label: {
                                TrialCard(trial: trial)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(AppGradientBackground())
            .navigationBarHidden(true)
        }
    }

    private var todaySetCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Today's Set")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppPalette.silverText)
                Spacer()
                Text("+1 500 Mind Points")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppPalette.softViolet)
            }
            Text("Complete any 3 trials from today's selection.")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
            VStack(alignment: .leading, spacing: 8) {
                ProgressChip(title: "0 / 3")
                CompactButton(title: "View Set", horizontalPadding: 14, verticalPadding: 8)
            }
        }
        .padding(14)
        .glassPanel(cornerRadius: 18)
    }
}

private struct TrialDetailView: View {
    let trial: Trial
    @State private var showActive = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(trial.name)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(AppPalette.silverText)
                    Text("\(trial.tags.first ?? "Focus") Trial")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppPalette.mutedSteel)
                }

                VStack(spacing: 18) {
                    ClubSymbolView(systemName: trial.icon)
                        .frame(maxWidth: .infinity)
                    HStack {
                        DetailStat(title: "Best Score", value: "72")
                        DetailStat(title: "Attempts Today", value: "2")
                        DetailStat(title: "Average Accuracy", value: "84%")
                    }
                }
                .padding(14)
                .glassPanel(cornerRadius: 22)

                Text(trial.description)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.mutedSteel)
                    .padding(14)
                    .glassPanel(cornerRadius: 18)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Base Reward: +\(trial.reward) Mind Points")
                        .foregroundStyle(AppPalette.silverText)
                    Text("Perfect Bonus: +200 Mind Points")
                        .foregroundStyle(AppPalette.softViolet)
                }
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .padding(14)
                .glassPanel(cornerRadius: 18)

                PrimaryButton(title: "Start Trial") {
                    showActive = true
                }
                CompactButton(title: "Practice Mode", horizontalPadding: 16, verticalPadding: 10)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(AppGradientBackground())
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showActive) {
            ActiveTrialView(trial: trial)
        }
    }
}

private struct ActiveTrialView: View {
    @Environment(\.dismiss) private var dismiss
    let trial: Trial

    @State private var timeRemaining = 24
    @State private var pulsePosition = 0.0
    @State private var score = 0
    @State private var taps = 0
    @State private var hits = 0
    @State private var finished = false

    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private let pulseTimer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()

    private var accuracy: Int {
        guard taps > 0 else { return 0 }
        return Int((Double(hits) / Double(taps)) * 100)
    }

    var body: some View {
        ZStack {
            AppGradientBackground()
            VStack(spacing: 18) {
                HStack {
                    Text(trial.name == "Pulse Window" ? "Pulse Window" : trial.name)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundStyle(AppPalette.silverText)
                    Spacer()
                    Text(String(format: "00:%02d", timeRemaining))
                        .font(.system(size: 23, weight: .bold, design: .monospaced))
                        .foregroundStyle(AppPalette.icyBlue)
                }
                .padding(.horizontal, 18)

                Spacer(minLength: 6)

                ZStack {
                    Circle()
                        .stroke(AppPalette.graphiteCard, lineWidth: 22)
                        .frame(width: 240, height: 240)
                    Circle()
                        .trim(from: 0.72, to: 0.84)
                        .stroke(AppPalette.softViolet, style: StrokeStyle(lineWidth: 22, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 240, height: 240)
                    Circle()
                        .trim(from: pulsePosition, to: min(pulsePosition + 0.06, 1.0))
                        .stroke(AppPalette.icyBlue, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 240, height: 240)
                    Text("\(score)")
                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                        .foregroundStyle(AppPalette.silverText)
                }
                .padding(.vertical, 6)

                if finished {
                    VStack(spacing: 8) {
                        ResultRow(title: "Score", value: "\(score)")
                        ResultRow(title: "Accuracy", value: "\(accuracy)%")
                        ResultRow(title: "Reaction Time", value: "312 ms")
                        ResultRow(title: "Earned Mind Points", value: "+\(max(180, score * 8))")
                    }
                    .padding(14)
                    .glassPanel(cornerRadius: 20)
                    .padding(.horizontal, 18)

                    VStack(spacing: 10) {
                        CompactButton(title: "Retry") {
                            reset()
                        }
                        CompactButton(title: "Back to Trials") {
                            dismiss()
                        }
                    }
                } else {
                    PrimaryButton(title: "Tap") {
                        taps += 1
                        let inTarget = pulsePosition >= 0.72 && pulsePosition <= 0.84
                        if inTarget {
                            hits += 1
                            score += 12
                        } else {
                            score = max(0, score - 3)
                        }
                    }
                    .padding(.horizontal, 18)
                }

                Spacer()
            }
        }
        .onReceive(timer) { _ in
            guard !finished else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                finished = true
            }
        }
        .onReceive(pulseTimer) { _ in
            guard !finished else { return }
            pulsePosition += 0.0065
            if pulsePosition > 1 {
                pulsePosition = 0
            }
        }
    }

    private func reset() {
        timeRemaining = 24
        pulsePosition = 0
        score = 0
        taps = 0
        hits = 0
        finished = false
    }
}

private struct ArtifactsView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Artifacts")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        Text("Relics earned through discipline")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(AppPalette.mutedSteel)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Artifact Progress")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(AppPalette.silverText)
                            Spacer()
                            Text("2 / 24 discovered")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundStyle(AppPalette.icyBlue)
                        }
                        HStack(spacing: 12) {
                            CircleProgressView(progress: 0.08, text: "8%")
                            Text("Complete rituals, streaks, and trial milestones to reveal new artifacts.")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(AppPalette.mutedSteel)
                        }
                    }
                    .padding(14)
                    .glassPanel(cornerRadius: 20)

                    LazyVStack(spacing: 10) {
                        ForEach(Artifact.samples) { artifact in
                            ArtifactCard(artifact: artifact)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(AppGradientBackground())
            .navigationBarHidden(true)
        }
    }
}

private struct MissionsView: View {
    @State private var showReward = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Missions")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        Text("Daily and weekly objectives")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(AppPalette.mutedSteel)
                    }

                    MissionCard(title: "Daily Ritual Mission", description: "Complete 3 trials before midnight.", progress: "1 / 3", reward: "+1 500 Mind Points", actionTitle: "Continue")
                    MissionCard(title: "Weekly Discipline", description: "Complete 15 trials this week.", progress: "4 / 15", reward: "+5 000 Mind Points", actionTitle: "View Trials")

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Streak Path")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        VStack(alignment: .leading, spacing: 9) {
                            StreakRow(day: "Day 1", reward: "+500")
                            StreakRow(day: "Day 2", reward: "+700")
                            StreakRow(day: "Day 3", reward: "Artifact fragment")
                            StreakRow(day: "Day 4", reward: "+1 200")
                            StreakRow(day: "Day 5", reward: "Focus Boost")
                            StreakRow(day: "Day 7", reward: "Rare Artifact")
                        }
                        CompactButton(title: "Claim Today's Reward") {
                            showReward = true
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .glassPanel(cornerRadius: 20)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Focus Enhancements")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        LazyVStack(spacing: 9) {
                            BoostCard(title: "Precision Boost", icon: "scope")
                            BoostCard(title: "Calm Boost", icon: "moon.stars")
                            BoostCard(title: "Memory Boost", icon: "brain.head.profile")
                            BoostCard(title: "Point Boost", icon: "sparkles")
                        }
                        CompactButton(title: "Activate Boost")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .glassPanel(cornerRadius: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(AppGradientBackground())
            .navigationBarHidden(true)
            .sheet(isPresented: $showReward) {
                RewardClaimView()
            }
        }
    }
}

private struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Profile")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        Text("Club status")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(AppPalette.mutedSteel)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Visitor")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        Text("0 Prestige")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppPalette.softViolet)
                        Text("Next: Initiate")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppPalette.mutedSteel)
                        VStack(alignment: .leading, spacing: 8) {
                            ProgressChip(title: "0%")
                            NavigationLink {
                                RankPathView()
                            } label: {
                                CompactButton(title: "View Rank Path", horizontalPadding: 12, verticalPadding: 8)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(14)
                    .glassPanel(cornerRadius: 20)

                    VStack(spacing: 8) {
                        ProfileStatRow(title: "Trials Completed", value: "0")
                        ProfileStatRow(title: "Mind Points", value: "12 800")
                        ProfileStatRow(title: "Current Streak", value: "1 Day")
                        ProfileStatRow(title: "Artifacts Found", value: "0")
                        ProfileStatRow(title: "Best Trial", value: "N/A")
                        ProfileStatRow(title: "Favorite Trial", value: "Mirror Sequence")
                        ProfileStatRow(title: "Accuracy Average", value: "N/A")
                    }
                    .padding(14)
                    .glassPanel(cornerRadius: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(AppGradientBackground())
            .navigationBarHidden(true)
        }
    }
}

private struct RankPathView: View {
    let ranks: [RankInfo] = [
        .init(name: "Visitor", requirement: "Start the app", reward: "Basic access"),
        .init(name: "Initiate", requirement: "Complete 3 trials", reward: "Unlock Daily Rituals"),
        .init(name: "Noble", requirement: "Earn 10 000 Mind Points", reward: "Unlock Weekly Missions"),
        .init(name: "Vanguard", requirement: "Complete 25 trials", reward: "Unlock rare Artifacts"),
        .init(name: "Regent", requirement: "Reach 7-day streak", reward: "Unlock advanced trials"),
        .init(name: "Grand Master", requirement: "Earn 100 000 Mind Points", reward: "Final prestige badge")
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
                Text("Rank Path")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(AppPalette.silverText)
                Text("Advance through Arcane Fortune Club")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.mutedSteel)

                ForEach(ranks) { rank in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(rank.name)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(AppPalette.silverText)
                        Text("Requirement: \(rank.requirement)")
                            .foregroundStyle(AppPalette.mutedSteel)
                        Text("Reward: \(rank.reward)")
                            .foregroundStyle(AppPalette.softViolet)
                    }
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .padding(12)
                    .glassPanel(cornerRadius: 16)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(AppGradientBackground())
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct RewardClaimView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppGradientBackground()
            VStack(spacing: 20) {
                Spacer()
                ClubSymbolView(systemName: "sparkles")
                    .scaleEffect(1.12)
                Text("Reward Claimed")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(AppPalette.silverText)
                Text("You earned 1 500 Mind Points")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppPalette.icyBlue)
                Text("Daily Ritual progress updated")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.mutedSteel)
                Spacer()
                PrimaryButton(title: "Continue") {
                    dismiss()
                }
                CompactButton(title: "View Missions") {
                    dismiss()
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 30)
        }
    }
}

private struct ClubSymbolView: View {
    let systemName: String

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            AppPalette.softViolet.opacity(0.34),
                            AppPalette.icyBlue.opacity(0.18),
                            .clear
                        ],
                        center: .center,
                        startRadius: 16,
                        endRadius: 130
                    )
                )
                .frame(width: 240, height: 240)
            Circle()
                .stroke(AppPalette.icyBlue.opacity(0.5), lineWidth: 1.2)
                .frame(width: 154, height: 154)
            Image(systemName: systemName)
                .font(.system(size: 56, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [AppPalette.icyBlue, AppPalette.softViolet],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .frame(height: 220)
    }
}

private struct AppGradientBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [AppPalette.deepObsidian, AppPalette.inkNavy],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(AppPalette.softViolet.opacity(0.11))
                .blur(radius: 50)
                .frame(width: 280, height: 280)
                .offset(x: -120, y: -260)

            Circle()
                .fill(AppPalette.icyBlue.opacity(0.1))
                .blur(radius: 56)
                .frame(width: 300, height: 300)
                .offset(x: 140, y: 280)
        }
        .ignoresSafeArea()
    }
}

private struct PrimaryButton: View {
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.deepObsidian)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [AppPalette.icyBlue, AppPalette.softViolet],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

private struct CompactButton: View {
    let title: String
    var horizontalPadding: CGFloat = 12
    var verticalPadding: CGFloat = 8
    var fillWidth: Bool = true
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
                .frame(maxWidth: fillWidth ? .infinity : nil)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
                .background(
                    Capsule()
                        .fill(AppPalette.inkNavy.opacity(0.92))
                        .overlay(
                            Capsule()
                                .stroke(AppPalette.icyBlue.opacity(0.5), lineWidth: 1)
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

private struct ProgressChip: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundStyle(AppPalette.icyBlue)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(AppPalette.icyBlue.opacity(0.14))
            )
    }
}

private struct CircleProgressView: View {
    let progress: Double
    let text: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(AppPalette.graphiteCard, lineWidth: 9)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [AppPalette.icyBlue, AppPalette.softViolet],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 9, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            Text(text)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
        }
        .frame(width: 76, height: 76)
    }
}

private struct MiniSkillIndicator: View {
    let name: String
    let complete: Bool

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(complete ? AppPalette.icyBlue : AppPalette.graphiteCard)
                .frame(width: 10, height: 20)
            Text(name)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(complete ? AppPalette.silverText : AppPalette.mutedSteel)
        }
    }
}

private struct TinyStatCard: View {
    let title: String
    let value: String
    let symbol: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: symbol)
                .foregroundStyle(AppPalette.icyBlue)
            Text(title)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .glassPanel(cornerRadius: 14)
    }
}

private struct NoteCard: View {
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "rays")
                .foregroundStyle(AppPalette.softViolet)
            Text(text)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
            Spacer()
        }
        .padding(12)
        .glassPanel(cornerRadius: 14)
    }
}

private struct TrialCard: View {
    let trial: Trial

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: trial.icon)
                    .foregroundStyle(AppPalette.icyBlue)
                Spacer()
                Text("+\(trial.reward)")
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppPalette.softViolet)
            }
            Text(trial.name)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
            Text(trial.tags.joined(separator: " / "))
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
                .lineLimit(1)
            Text(trial.description)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel.opacity(0.95))
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .glassPanel(cornerRadius: 16)
    }
}

private struct DetailStat: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
            Text(title)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ResultRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(AppPalette.mutedSteel)
            Spacer()
            Text(value)
                .foregroundStyle(AppPalette.silverText)
        }
        .font(.system(size: 15, weight: .semibold, design: .rounded))
    }
}

private struct ArtifactCard: View {
    let artifact: Artifact

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .fill(AppPalette.inkNavy.opacity(0.72))
                Image(systemName: artifact.icon)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(AppPalette.softViolet)
            }
            .frame(height: 74)

            Text(artifact.name)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)

            Text("Status: Locked")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(AppPalette.icyBlue)

            Text("Condition: \(artifact.condition)")
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .glassPanel(cornerRadius: 16)
    }
}

private struct MissionCard: View {
    let title: String
    let description: String
    let progress: String
    let reward: String
    let actionTitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
            Text(description)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
            HStack {
                ProgressChip(title: progress)
                Spacer()
                Text(reward)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(AppPalette.softViolet)
            }
            CompactButton(title: actionTitle)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .glassPanel(cornerRadius: 20)
    }
}

private struct StreakRow: View {
    let day: String
    let reward: String

    var body: some View {
        HStack(spacing: 10) {
            VStack(spacing: 0) {
                Circle()
                    .fill(AppPalette.icyBlue)
                    .frame(width: 9, height: 9)
                Rectangle()
                    .fill(AppPalette.icyBlue.opacity(0.35))
                    .frame(width: 2, height: 18)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(day)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(AppPalette.silverText)
                Text(reward)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(AppPalette.mutedSteel)
            }
        }
    }
}

private struct BoostCard: View {
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(AppPalette.icyBlue)
            Text(title)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
            Spacer()
        }
        .padding(10)
        .glassPanel(cornerRadius: 14)
    }
}

private struct ProfileStatRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(AppPalette.mutedSteel)
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(AppPalette.silverText)
        }
        .padding(.vertical, 4)
    }
}

private struct Trial: Identifiable {
    let id = UUID()
    let name: String
    let tags: [String]
    let description: String
    let reward: Int
    let icon: String

    static let samples: [Trial] = [
        .init(name: "Mirror Sequence", tags: ["Memory", "Speed"], description: "Symbols appear in order. Repeat the sequence before it fades.", reward: 450, icon: "square.grid.3x3.fill"),
        .init(name: "Pulse Window", tags: ["Timing", "Reflex"], description: "Tap when the pulse enters the narrow active zone.", reward: 380, icon: "waveform.path.ecg"),
        .init(name: "Rune Match", tags: ["Memory", "Accuracy"], description: "Open rune cards and find pairs with minimal mistakes.", reward: 520, icon: "seal"),
        .init(name: "Orbit Lock", tags: ["Precision", "Focus"], description: "Keep the moving object inside a glowing orbit ring.", reward: 600, icon: "atom"),
        .init(name: "Signal Trace", tags: ["Reaction", "Attention"], description: "Tap only the correct flashing signals at speed.", reward: 430, icon: "dot.radiowaves.left.and.right"),
        .init(name: "Silent Count", tags: ["Calm", "Focus"], description: "Count delayed impulses and select the final total.", reward: 500, icon: "ear"),
        .init(name: "Shard Sort", tags: ["Logic", "Speed"], description: "Sort shapes by color, form, or direction quickly.", reward: 470, icon: "triangle.lefthalf.filled"),
        .init(name: "Focus Gate", tags: ["Attention", "Precision"], description: "Guide a point through moving gates without touching borders.", reward: 650, icon: "scope")
    ]
}

private struct Artifact: Identifiable {
    let id = UUID()
    let name: String
    let condition: String
    let icon: String

    static let samples: [Artifact] = [
        .init(name: "Obsidian Lens", condition: "Complete 3 Memory trials", icon: "circle.hexagongrid"),
        .init(name: "Violet Compass", condition: "Reach 5-day streak", icon: "location.north.line"),
        .init(name: "Silver Sigil", condition: "Earn 20 000 Mind Points", icon: "seal.fill"),
        .init(name: "Glass Monolith", condition: "Score 90+ in Pulse Window", icon: "rectangle.portrait"),
        .init(name: "Echo Medallion", condition: "Complete 10 Daily Rituals", icon: "smallcircle.filled.circle"),
        .init(name: "Astral Key", condition: "Unlock Regent rank", icon: "key.fill")
    ]
}

private struct RankInfo: Identifiable {
    let id = UUID()
    let name: String
    let requirement: String
    let reward: String
}

private struct AppPalette {
    static let deepObsidian = Color(hex: 0x090B12)
    static let inkNavy = Color(hex: 0x101827)
    static let graphiteCard = Color(hex: 0x171E2E)
    static let icyBlue = Color(hex: 0x8FD8FF)
    static let softViolet = Color(hex: 0xB69CFF)
    static let silverText = Color(hex: 0xEEF3FA)
    static let mutedSteel = Color(hex: 0x8E9AAD)
}

private extension View {
    func glassPanel(cornerRadius: CGFloat = 20) -> some View {
        background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.08),
                            AppPalette.graphiteCard.opacity(0.9)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    AppPalette.icyBlue.opacity(0.45),
                                    AppPalette.softViolet.opacity(0.26)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
    }
}

private extension Color {
    init(hex: UInt, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
