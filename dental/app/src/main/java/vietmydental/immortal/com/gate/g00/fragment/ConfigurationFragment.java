package vietmydental.immortal.com.gate.g00.fragment;


import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.google.firebase.iid.FirebaseInstanceId;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import vietmydental.immortal.com.gate.component.BaseFragment;
import vietmydental.immortal.com.gate.g00.view.G00HomeActivity;
import vietmydental.immortal.com.gate.model.BaseModel;
import vietmydental.immortal.com.gate.utils.DomainConst;
import vietmydental.immortal.com.vietmydental.R;

/**
 * A simple {@link Fragment} subclass.
 */
public class ConfigurationFragment extends BaseFragment<G00HomeActivity> {
//    @BindView(R.id.txtContent)
//    public TextView textView;

    //++ BUG0032-IMT (KhoiVT 20180921) [Android] Các màn hình vệ tinh
    @OnClick(R.id.view_update_version)
    public void updateVersion(View view) {
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(Uri.parse("market://details?id=vietmydental.immortal.com.vietmydental"));
            startActivity(intent);
    }

    public ConfigurationFragment() {
        // Required empty public constructor
    }
    //-- BUG0032-IMT (KhoiVT 20180921) [Android] Các màn hình vệ tinh

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View rootView = inflater.inflate(R.layout.fragment_configuration, container, false);
        ButterKnife.bind(this, rootView);
        //textView.setText(FirebaseInstanceId.getInstance().getToken());
        return rootView;
    }

    /**
     * Get fragment UUID.
     *
     * @return Fragment UUID
     */
    @Override
    public String getFragmentUUID() {
        return DomainConst.MENU_ID_LIST.CONFIGURATION;
    }

    /**
     * Get title config to show on menu
     *
     * @return
     */
    @Override
    public TitleConfigObject getTitleConfig() {
        return new BaseFragment.TitleConfigObject(true, false);
    }
}
