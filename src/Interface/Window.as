class Window
{
    bool isOpened = false;

    array<Tab@> tabs;
    Tab@ activeTab;
    Tab@ lastActiveTab;

    // Main Tabs
    Window()
    {
        AddTab(GraphicsTab());
        AddTab(EnvironmentTab());
#if TMNEXT
        AddTab(CameraTab());
        AddTab(SpecialTab());
#endif
        AddTab(InterfaceTab());
    }

    void AddTab(Tab@ tab, bool select = false){
        tabs.InsertLast(tab);
        if (select) {
            @activeTab = tab;
        }
    }

    void Render()
    {
        if (UI::Begin(title, isOpened)){
            // Push the last active tab style so that the separator line is colored (this is drawn in BeginTabBar)
            auto previousActiveTab = lastActiveTab;
            if (previousActiveTab !is null) {
                previousActiveTab.PushTabStyle();
            }
            UI::BeginTabBar("Tabs");

            for(uint i = 0; i < tabs.Length; i++){
                auto tab = tabs[i];
                if (!tab.IsVisible()) continue;

                UI::PushID(tab);

                int flags = 0;
                if (tab is activeTab) {
                    flags |= UI::TabItemFlags::SetSelected;
                    if (!tab.GetLabel().Contains("Loading")) @activeTab = null;
                }

                tab.PushTabStyle();

                if (tab.CanClose()){
                    bool open = true;
                    if(UI::BeginTabItem(tab.GetLabel(), open, flags)){
                        @lastActiveTab = tab;

                        UI::BeginChild("Tab");
                        tab.Render();
                        UI::EndChild();

                        UI::EndTabItem();
                    }
                    if (!open){
                        tabs.RemoveAt(i--);
                    }
                } else {
                    if(UI::BeginTabItem(tab.GetLabel(), flags)){
                        @lastActiveTab = tab;

                        UI::BeginChild("Tab");
                        tab.Render();
                        UI::EndChild();

                        UI::EndTabItem();
                    }
                }

                tab.PopTabStyle();

                UI::PopID();

            }

            UI::EndTabBar();

            // Pop the tab style (for the separator line) only after EndTabBar, to satisfy the stack unroller
            if (previousActiveTab !is null) {
                previousActiveTab.PopTabStyle();
            }
        }
        UI::End();
    }
}